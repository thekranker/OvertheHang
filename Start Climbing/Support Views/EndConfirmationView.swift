//
//  EndConfirmationView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/28/23.
//

import SwiftUI

struct EndConfirmationView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    
    @Binding var endOfWorkout: Bool
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            
            // CONFIRM END WORKOUT
            Text("End Workout?")
                .font(.system(size: 18))
                .fontWeight(.semibold)
            SeparatorView(color: .gray)
            
            HStack {
                
                // YES
                VStack {
                    Button {
                        endOfWorkout = true
                        workoutManager.endWorkout()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(.green)
                    .font(.title2)
                }
                
                
                // NO
                VStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.red)
                    .font(.title2)
                }
                
                
                
            } //: HStack
        } //: VStack
        
        // Displays SummaryView() upon end of workout
       .sheet(isPresented: $workoutManager.showingSummaryView, onDismiss: { dismiss() }, content: {
           SummaryView()
       })
        
        .navigationBarHidden(true)
    } //: body
} //: EndConfirmationView
