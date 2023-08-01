//
//  MetricsView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/8/23.
//

import SwiftUI

struct MetricsView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 10)
            
            
            // TOTAL CLIMBS
            HStack {
                Text("Climbs: ") // Displays total climbs
                    .foregroundColor(.green)
                Text(String(workoutManager.totalClimbs))
                Spacer()
            }
            .font(.system(size: 23)
                .monospacedDigit()
                .lowercaseSmallCaps()
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
            
            
            
            
            // SEPARATOR
            SeparatorView(color: .green)
            
            
            
            
            // WORKOUT METRICS
            VStack(alignment: .leading) {
                
                // Calories Burned
                Text(
                    Measurement( // Displays active energy burned
                        value: workoutManager.activeEnergy,
                        unit: UnitEnergy.kilocalories
                        ).formatted(
                            .measurement(width: .abbreviated,
                                            usage: .workout)
                        )
                    )
                    
                // Heart Rate (BPM)
                Text (
                    workoutManager.heartRate.formatted( // Displays heart rate
                        .number.precision(.fractionLength(0))
                    )
                    + " bpm"
                )
            } //: VStack
            
            
            
            
            // SEPARATOR
            SeparatorView(color: .orange)
            
               
            
            
            // HIGHEST GRADE CLIMBED
            HStack {
                Text("Highest: ")
                    .foregroundColor(.orange)
                
                if (workoutManager.highestGrade == -1) { // Displays n/a if no completed climbs
                    Text("N/A")
                        .font(.system(size: 22))
                }
                else {
                    Text("V" + String(workoutManager.highestGrade)) // Displays highest grade
                        .font(.system(size: 23))
                }
                Spacer()
            } //: HStack
            .font(.system(size: 23) // Formatting
                .monospacedDigit()
                .lowercaseSmallCaps()
            )
            .frame(maxWidth: .infinity, alignment: .leading) // Formatting
            .ignoresSafeArea(edges: .bottom)
            .scenePadding()
                
                
        
            
        } //: VStack
    } //: body
} //: MetricsView

// MARK: - PREVIEW

struct MetricsView_Previews: PreviewProvider {
    static var previews: some View {
        MetricsView()
    }
}
