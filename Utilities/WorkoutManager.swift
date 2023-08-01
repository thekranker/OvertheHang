//
//  WorkoutManager.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/9/23.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject {
    
    // MARK: - PROPERTY
    
    @Published var countWorkouts = 0
    @Published var showingSummaryView: Bool = false
    
    
    // Checks if a workout is set, if set, starts a workout, otherwise returns
    var selectedWorkout: HKWorkoutActivityType? {
        didSet {
            guard oldValue == nil  && selectedWorkout != nil else { return }
            startWorkout()
        } //: didSet
    } //: selectedWorkout
    
    
    let healthStore = HKHealthStore()
    var session: HKWorkoutSession?
    var builder: HKLiveWorkoutBuilder?
    var workouts: [HKWorkout]?
    
    
    var highestGrade = -1
    var totalClimbs = 0
    
    
    // Stores climbing grade data
    var metadataDictionary = [
        "AppName": 951,
        "TotalClimbs": 0,
        "HighestGradeClimbed": -1,
        "V0": 0,
        "V1": 0,
        "V2": 0,
        "V3": 0,
        "V4": 0,
        "V5": 0,
        "V6": 0,
        "V7": 0,
        "V8": 0,
        "V9": 0,
        "V10": 0,
        "AvgHeartRate": 0,
        "TotalCalories": 0
    ]
    
    
    var stats = [
        0, // V0
        0, // V1
        0, // V2
        0, // V3
        0, // V4
        0, // V5
        0, // V6
        0, // V7
        0, // V8
        0, // V9
        0 // V10
    ]
    
    var allTimeTotalClimbs = 0
    
    
    // MARK: - requestAuthorization()
    
    // Request authorization to access HealthKit
    func requestAuthorization() {
        
        let typesToShare: Set <HKSampleType> = [ // The quantity type to write to the health store
            HKQuantityType.workoutType()
            ]
        
        let typesToRead: Set = [ // Types requested for access to from user
            HKQuantityType.workoutType(),
            HKSeriesType.activitySummaryType(),
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            ]
        
        // Request authorization for those quantity types
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead)
        { (success, error) in
            // Handle error
        }
        
    } //: requestAuthorization()
    
    
    // MARK: - SESSION STATUS
    
    @Published var running = false // The workout session state
        
        
    // MARK: - startWorkout()
    
    func startWorkout() {
        
        // Sets activity to climbing and declares it as an indoor sport
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .climbing
        configuration.locationType = .indoor
        
        
        do {
            session = try HKWorkoutSession(
                healthStore: healthStore,
                configuration: configuration
                )
            builder = session?.associatedWorkoutBuilder()
        } catch {
            // Handle any exceptions
            return
        } //: catch
        
        
        builder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration
            )
        
        
        session?.delegate = self
        builder?.delegate = self
        
        
        // Start the workout session & begin data collection
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate) { (success, error) in
            // The workout has started
        }
    } //: startWorkout()
    
    
   // MARK: - endWorkout()
    
    func endWorkout() { // Ends the Workout
        session?.end()
        showingSummaryView = true
    }
    
    
    // MARK: - resetWorkout()
    
    // Resets Workout Statistics
    func resetWorkout() {
        
        selectedWorkout = nil
        builder = nil
        session = nil
        workout = nil
        
        activeEnergy = 0
        averageHeartRate = 0
        heartRate = 0
        
        
        metadataDictionary = [
            "AppName": 951,
            "TotalClimbs": 0,
            "HighestGradeClimbed": -1,
            "V0": 0,
            "V1": 0,
            "V2": 0,
            "V3": 0,
            "V4": 0,
            "V5": 0,
            "V6": 0,
            "V7": 0,
            "V8": 0,
            "V9": 0,
            "V10": 0,
            "AvgHeartRate": 0,
            "TotalCalories": 0
        ]
        

        highestGrade = -1
        totalClimbs = 0
        
    } //: resetWorkout
        
    
    // MARK: - storeClimbData()
    
    // Stores climbing data in the "completedClimbs" array
    func storeClimbData(climbGrade: Int) {
        
        if (climbGrade > highestGrade) { // Sets "highestCompletedGrade"
            highestGrade = climbGrade
        } // if
        
        let climbGradeLevel = "V\(climbGrade)"
        metadataDictionary[climbGradeLevel]! += 1
        totalClimbs += 1
        
    } //: storeClimbData
    
    
    // MARK: - retrieveWorkouts()
    
    // Retrieves the workouts to be viewed in "SessionListView" as stats
    func retrieveWorkouts() {
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        let climbing = HKQuery.predicateForWorkouts(with: .climbing)
        
        let query = HKSampleQuery(sampleType: .workoutType(), predicate: climbing, limit: 15, sortDescriptors: [sortDescriptor]) { (query, tmpResult, error) -> Void in
            
            if error != nil {
                // something happened
                print("Error when running query!")
                return
            }
            
            
            DispatchQueue.main.async {
                // Update the UI here.
                self.workouts = tmpResult as? [HKWorkout]
                self.countWorkouts = self.workouts?.count ?? 0
                self.calculateStats()
            }
        }
        healthStore.execute(query)
    } // retrieveWorkouts()
    
    
    // MARK: - calculateStats()
    
    func calculateStats() {
        
        self.stats = [
            0, // V0
            0, // V1
            0, // V2
            0, // V3
            0, // V4
            0, // V5
            0, // V6
            0, // V7
            0, // V8
            0, // V9
            0 // V10
        ]
        
        if (countWorkouts > 0) {
            for workout in self.workouts! {
                
                let metadata = workout.metadata ?? [:]
                
                for grade in 0..<11 {
                    
                    stats[grade] += metadata["V\(grade)"] as? Int ?? 0
                    
                } //: for every grade
                
            } //: for every workout
            
            for climb in 0..<11 { // Calculates total climbs
                allTimeTotalClimbs += stats[climb]
            } //: for
            
        } //: if
    } //: calculateStats
    
    
    // MARK: - WORKOUT METRICS
    
    @Published var averageHeartRate: Double = 0
    @Published var heartRate: Double = 0
    @Published var activeEnergy: Double = 0
    @Published var workout: HKWorkout?
    
    
    
    // Displays live statistics for various metrics during workout
    func updateForStatistics(_ statistics: HKStatistics?) {
            guard let statistics = statistics else { return }

            DispatchQueue.main.async {
                switch statistics.quantityType {
                case HKQuantityType.quantityType(forIdentifier: .heartRate):
                    let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                    self.heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                    self.averageHeartRate = statistics.averageQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                    let energyUnit = HKUnit.kilocalorie()
                    self.activeEnergy = statistics.sumQuantity()?.doubleValue(for: energyUnit) ?? 0
                default:
                    return
                } //: switch
            } //: DispatchQueue
        } //: updateForStatistics
} //: WorkoutManager



// MARK: - EXTENSION

extension WorkoutManager: HKWorkoutSessionDelegate {
    
    // Called when an error occurs that stops the workout session
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
    } //: workoutSession
    
    
    // Called when a workout session transitions into a new state
    func workoutSession(_ workoutSession: HKWorkoutSession,
                        didChangeTo toState: HKWorkoutSessionState,
                        from fromState: HKWorkoutSessionState,
                        date: Date) {
        
        DispatchQueue.main.async {
            self.running = toState == .running
        } //: DispatchQueue
        
        // Wait for the session to transition states before ending the builder
        if toState == .ended {
            
            
            // Storing the session climb data in HealthKit
            metadataDictionary["TotalClimbs"] = totalClimbs
            metadataDictionary["HighestGradeClimbed"] = highestGrade
            metadataDictionary["AvgHeartRate"] = Int(averageHeartRate)
            metadataDictionary["TotalCalories"] = Int(activeEnergy)
            
            
            builder?.addMetadata(metadataDictionary) { (success, error) in }
            
            builder?.endCollection(withEnd: date) { (success, error) in // Ends the workout
                self.builder?.finishWorkout { (workout, error) in // Collects the data
                    DispatchQueue.main.async {
                        self.workout = workout
                    } //: DispatchQueue
                } //: finishWorkout
            } //: endCollection
        } //: if
    } //: workoutSession
} // WorkoutManager



extension WorkoutManager: HKLiveWorkoutBuilderDelegate {
    
    // Called every time a new event is added to workout builder
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
    }
    
    // Makes sure the values collected are collected
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder,
                        didCollectDataOf collectedTypes: Set<HKSampleType>) {
        
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else { return }
            
            
            let statistics = workoutBuilder.statistics(for: quantityType)
            // Update the published values
            updateForStatistics(statistics)
            
        } //: for
    } //: workoutBuilder
} //: WorkoutManager
