//
//  SessionPagingView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/8/23.
//

import SwiftUI

struct SessionPagingView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var selection: Tab = .addClimb // Selects AddClimbView() upon appearance
    
    enum Tab { // Stores the various tabs of a workout
        case endSession, addClimb, metricsView
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        
        // TAB VIEW
        TabView(selection: $selection) { // "Swipe to switch tabs" format
            EndSessionView().tag(Tab.endSession)
            AddClimbView().tag(Tab.addClimb)
            MetricsView().tag(Tab.metricsView)
        } //: TabView
        .navigationTitle("Climbing")
        .navigationBarBackButtonHidden(true)
       
    
        .onAppear() { // Starts a workout when AddClimbView() appears
            workoutManager.selectedWorkout = .climbing
        } //: onAppear
        
    } //: body
} //: SessionPagingView


// MARK: - PREVIEW

struct SessionPagingView_Previews: PreviewProvider {
    static var previews: some View {
        SessionPagingView()
    }
}
