//
//  DataSheetView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/17/23.
//

import SwiftUI
import HealthKit
import Foundation

struct DataSheetView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @Binding var showDataSheet: Bool
    @Binding var selectedWorkout: HKWorkout?
    @Binding var metadata: [String : Any]?
    
    
    // Stored metadata
    @State var highestGradeClimbed = -1
    @State var totalClimbs = 0
    @State var climbs: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @State var avgHeartRate = 0
    @State var totalCalories = 0
    
    
    // MARK: - FUNCTION
    
    // Displays a time interval in a proper time format
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    } //: stringFromTimeInterval
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            
            // TITLE (DATE)
            Text("\(selectedWorkout!.startDate.formatted(date: .abbreviated, time: .omitted))")
                .font(.system(.title3, design: .rounded, weight: .semibold)
                    .monospacedDigit()
                    .lowercaseSmallCaps()
                )
            Divider()
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    
                    
                    // GENERAL
                    Group {
                        
                        // Title
                        Text("General")
                            .font(.system(size: 16))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.secondary)
                        Spacer()
                        
                        // Duration of Workout
                        Text("Duration")
                            .font(.system(size: 15))
                            .foregroundColor(.yellow)
                        + Text(": \(stringFromTimeInterval(interval: selectedWorkout!.duration))")
                            .font(.system(size: 15))
                        
                        // Highest Grade Climbed
                        Text("Highest")
                            .font(.system(size: 15))
                            .foregroundColor(.green)
                        + Text((highestGradeClimbed >= 0) ? ": V\(highestGradeClimbed)": " n/a")
                            .font(.system(size: 15))
                        
                        // Total Climbs
                        Text("Total Climbs")
                            .font(.system(size: 15))
                            .foregroundColor(.orange)
                        + Text(": \(totalClimbs)")
                            .font(.system(size: 15))
                        SeparatorView(color: .gray)
                    } //: Group
                    
                    
                    
                    
                    // GRADE INFO
                    Group {
                        
                        // Title
                        Text("Grade Info")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        // Grade Info
                        ScrollView(.horizontal) {
                            HStack {
                                Spacer().frame(width: 5)
                                    
                                ForEach(0..<11) { grade in
                                    // Displays individual grade count
                                    if (climbs[grade] != 0) { CircleSummaryView(numCompleted: String(climbs[grade]), grade: "V\(grade)")
                                        Spacer().frame(width: 12)
                                    } //: if
                                } //: ForEach
                            } //: HStack
                        } //: ScrollView(.horizontal)
                        Spacer()
                            .frame(height: 10)
                        SeparatorView(color: .gray)
                    } //: Group
                    
                    
                    
                    
                    // HEALTH
                    Group {
                        
                        // Title
                        Text("Health")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(alignment: .leading){
                            
                            // Heart Rate
                            Text("Heart Rate")
                                .font(.system(size: 15))
                                .foregroundColor(.green)
                            + Text(": \(avgHeartRate) BPM")
                                .font(.system(size: 15))
                            
                            // Total Calories
                            Text("Total Calories")
                                .font(.system(size: 15))
                                .foregroundColor(.orange)
                            + Text(": \(totalCalories) CAL")
                                .font(.system(size: 15))
                            
                        } // VStack
                    } //: Group
                    .ignoresSafeArea(.all)
                } //: VStack(alignment: .leading)
                
                
                
                
                // DISMISS BUTTON
                Divider()
                Spacer()
                    .frame(height: 10)
                HStack {
                    Spacer()
                    Button { // Dismiss sheet
                        showDataSheet.toggle()
                    } label: {
                        Text("Done")
                    }
                    Spacer()
                } //: HStack
                
                
                
                
            } //: ScrollView(.vertical)
        } //: VStack
        .navigationTitle("Stats")
        
        
        // MARK: - METADATA
        
        // Unwraps & stores metadata upon appearance
        .onAppear() {
            if let metadata = metadata {
                self.totalClimbs = metadata["TotalClimbs"] as? Int ?? 0
                self.highestGradeClimbed = metadata["HighestGradeClimbed"] as? Int ?? -1
                self.climbs[0] = metadata["V0"] as? Int ?? 0
                self.climbs[1] = metadata["V1"] as? Int ?? 0
                self.climbs[2] = metadata["V2"] as? Int ?? 0
                self.climbs[3] = metadata["V3"] as? Int ?? 0
                self.climbs[4] = metadata["V4"] as? Int ?? 0
                self.climbs[5] = metadata["V5"] as? Int ?? 0
                self.climbs[6] = metadata["V6"] as? Int ?? 0
                self.climbs[7] = metadata["V7"] as? Int ?? 0
                self.climbs[8] = metadata["V8"] as? Int ?? 0
                self.climbs[9] = metadata["V9"] as? Int ?? 0
                self.climbs[10] = metadata["V10"] as? Int ?? 0
                self.avgHeartRate = metadata["AvgHeartRate"] as? Int ?? 0
                self.totalCalories = metadata["TotalCalories"] as? Int ?? 0
            } //: metadata
        } //: onAppear
        
        
    } //: body
} //: DataSheetView


// MARK: - CircleSummaryView

// The default circular display to display individual grade data
struct CircleSummaryView: View {
    
    var numCompleted: String
    var grade: String
    
    
    var body: some View {
        VStack {
                Spacer()
                ZStack {
                    
                    
                    // CIRCLE + TEXT
                    Circle()
                        .trim(from: 0.0, to: 1.0)
                        .stroke(Color.cyan, lineWidth: 4)
                    Text(numCompleted)
                        .fontWeight(.semibold)
                } //: ZStack
                .frame(width: 40, height: 40)
            
            
            // TEXT
            Text(grade)
                .font(.system(.title3))
                .fontWeight(.semibold)
        } //: VStack
    } //: body
} //: CircleSummaryView

