//
//  Over_the_HangApp.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/14/23.
//

import SwiftUI

@main
struct Over_the_Hang_Watch_AppApp: App {
    @StateObject private var workoutManager = WorkoutManager()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environmentObject(workoutManager) // Creates "workoutManager" Environment Object
        }
    }
}

