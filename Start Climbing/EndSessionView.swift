//
//  EndSessionView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/8/23.
//

import SwiftUI

struct EndSessionView: View {
    
// MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    
    @State var isGoalsPresented = false
    @State var isConfirmationPresented = false
    @State var endOfWorkout = false
    
    
// MARK: - BODY
    
    var body: some View {
        
        
        // TIMELINE
        TimelineView(
            ControlsTimelineSchedule( // Creates a new timeline
                from: workoutManager.builder?.startDate ?? Date()
                )
        ) {context in
            
            VStack {
                Spacer()
                

                
                // ELAPSED TIME
                ElapsedTimeView( // Displays elapsed time
                    elapsedTime: workoutManager.builder?.elapsedTime ?? 0,
                    showSubseconds: context.cadence == .live
                ).foregroundColor(.white)
                    .font(.system(.title, design: .rounded)
                        .monospacedDigit()
                        .lowercaseSmallCaps()
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .ignoresSafeArea(edges: .bottom)
                    .scenePadding()
                
                Spacer()
                Divider()

                
                
                // END
                HStack {
                    VStack {
                        Button { // Displays confirmation sheet
                            isConfirmationPresented.toggle()
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .tint(.red)
                        .font(.title2)
                        Text("End")
                    } //: VStack
                    .sheet(isPresented: $isConfirmationPresented) {
                        EndConfirmationView(endOfWorkout: $endOfWorkout)
                        
                    }
                    
                    
                    
                    // GOALS
                    VStack {
                        Button {
                            isGoalsPresented.toggle()
                        } label: {
                            Image(systemName: "trophy.fill")
                                .imageScale(.small)
                        }
                        .tint(.yellow)
                        .font(.title2)
                        Text("Goals")
                    }
                    .sheet(isPresented: $isGoalsPresented) {
                        InProgressView()
                    }
                    
                    
                    
                    
                } //: HStack
            } //: VStack
            .onAppear() {
                if (endOfWorkout) {
                   dismiss()
                } //: if
            } //: onAppear
            
        } //: TimelineView
    } //: body
} //: EndSessionView


// MARK: - PREVIEW

struct EndSessionView_Previews: PreviewProvider {
    static var previews: some View {
        EndSessionView()
    }
}


// MARK: - Timeline

// Creates a timeline to display the live duration of the workout
private struct ControlsTimelineSchedule: TimelineSchedule {
    var startDate: Date
    
    
    init(from startDate: Date) { // Starts timeline at current time
        self.startDate = startDate
    }
    
    
    func entries(from startDate: Date,
                 mode: TimelineScheduleMode) ->
    PeriodicTimelineSchedule.Entries {
        PeriodicTimelineSchedule(from: self.startDate,
                                 by: (mode == .lowFrequency ? 1.0 : 1.0 / 30.0)
        ).entries(from: startDate, mode: mode)
    }
} //: ControlsTimelineSchedule
