//
//  SessionListView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/8/23.
//

import SwiftUI
import HealthKit

struct LatestSessionsView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State var showDataSheet = false
    @State var selectedWorkout: HKWorkout?
    @State var metadata: [String : Any]?
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            
            // TITLE
            Text("Latest Sessions")
                .fontWeight(.semibold)
            Divider()
            
            
            
            // LIST
            if (workoutManager.countWorkouts > 0) {
                List {
                    ForEach(workoutManager.workouts!, id: \.self) { workout in
                        if let metadata = workout.metadata {
                            if (metadata["AppName"] as? Int ?? 0 == 951) {
                                Button {
                                    showDataSheet.toggle()
                                    self.selectedWorkout = workout
                                    self.metadata = workout.metadata
                                    
                                } label: {
                                    Text("\(workout.startDate.formatted(date: .numeric, time: .shortened))")
                                        .foregroundColor(.secondary)
                                }
                            } //: if AppName == 951
                        } //: if metadata
                    } //: ForEach
                } //: List
            } //: if
            
            
            
            // IMAGE
            else {
                Spacer()
                Image(systemName: "figure.climbing")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(15)
            } //: else
            
            
            
        } //: VStack
        
        .sheet(isPresented: $showDataSheet, content: { // Displays data sheet
            DataSheetView(showDataSheet: $showDataSheet, selectedWorkout: $selectedWorkout, metadata: $metadata)
                .navigationBarHidden(true)
        }) //: sheet
        
        .onAppear() {
            workoutManager.retrieveWorkouts()
        } //: onAppear
        
    } //: body
} //: LatestSessionsView


// MARK: - PREVIEW

struct LatestSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        LatestSessionsView()
    }
}
