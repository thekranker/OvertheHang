//  ContentView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/7/23.
//

import SwiftUI
import CoreLocation


struct ContentView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State private var isSettingsPresented = false
    @State private var isCreditsPresented = false
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 15)
            
                
            
            // START CLIMBING
            NavigationLink(destination: SessionPagingView()) { // "Start Climbing" navigation link
                Capsule()
                    .frame(width: 4)
                    .foregroundColor(.green)
                Text("Start Climbing")
                    .frame(width: 117 , height: 10)
                Image(systemName: "play.fill")
            } //: NavigationLink
            
            
            
            // ACHIEVEMENTS
            NavigationLink(destination: AchievementsPagingView()) { // "Achievements" Navigation Link
                Capsule()
                    .frame(width: 4)
                    .foregroundColor(.orange)
                Text("Achievements")
                    .frame(width: 116, height: 10)
                Image(systemName: "trophy.fill")
            } //: NavigationLink
            
        

            // STATS + SETTINGS & CREDITS
            HStack {
                NavigationLink(destination: SettingsView()) { // "Settings" Navigation Link
                    Image(systemName: "gear")
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                }
                .tint(Color.clear)
                .fixedSize()
                
                
                NavigationLink(destination: LatestSessionsView()) { // "Stats" Navigation Link
                    Text("Stats")
                        .frame(width: 50, height: 10)
                } //: NavigationLink
                
                
                NavigationLink(destination: CreditsPagingView()) { // "Credits" Navigation Link
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .foregroundColor(.secondary)
                }
                .tint(Color.clear)
                .fixedSize()
            } //: HStack
                
               
            
        } //: VStack
        .navigationTitle("O'Hang")
        .navigationBarTitleDisplayMode(.inline)
            
        .onAppear {
            // Requests authorization for Health Kit to access workout information
            workoutManager.requestAuthorization()
            workoutManager.resetWorkout()
        } //: onAppear

    } //: body
} //: ContentView


// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
