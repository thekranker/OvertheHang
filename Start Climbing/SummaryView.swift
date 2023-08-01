//
//  SummaryView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/8/23.
//

import SwiftUI
import HealthKit

struct SummaryView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @Environment(\.dismiss) var dismiss
    
    @State private var durationFormatter:
    
    DateComponentsFormatter = { // Formats the elapsed time
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    } ()
    
    
    // MARK: - BODY
    
    var body: some View {
        
        
        // SAVING WORKOUT SCREEN
        if workoutManager.workout == nil {
            ProgressView("Saving workout")
                .tint(.white)
                .font(.system(size: 17))
                .font(.system(.title, design: .rounded)
                    .lowercaseSmallCaps()
                      )
                .foregroundColor(.white)
                .navigationBarHidden(true)
            
            
            // SUMMARY SCREEN
        } else {
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    
                    
                    // Elapsed Time
                    SummaryBoxView(title: "Total Time",
                                   value: durationFormatter.string(from: workoutManager.workout?.duration ?? 0.0) ?? "")
                    .accentColor(Color.yellow)
                    
                    
                    // Completed Climbs
                    SummaryBoxView(title: "Completed Climbs",
                                   value: String(workoutManager.totalClimbs))
                        .accentColor(Color.green)
                    
                    
                    // Highest Grade
                    if (workoutManager.highestGrade == -1) {
                        SummaryBoxView(title: "Highest Grade",
                                       value: "N/A")
                            .accentColor(Color.orange)
                    } //: if
                    else {
                        SummaryBoxView(title: "Highest Grade",
                                       value: "V" + String(workoutManager.highestGrade))
                            .accentColor(Color.orange)
                    } //: else
                    
                         
                    // Activity Rings
                    Text("Activity Rings")
                        .font(.system(size: 17))
                        .font(.system(.title, design: .rounded)
                            .lowercaseSmallCaps()
                              )
                        .foregroundColor(.white)
                    ActivityRingsView(
                        healthStore: HKHealthStore()
                    ).frame(width: 43, height: 43)
                    
                    
                    // Done Button
                    Button() {
                        dismiss()
                    } label: {
                        Text("Done")
                            .font(.system(size: 17))
                            .font(.system(.title, design: .rounded)
                                .lowercaseSmallCaps()
                                  )
                            .foregroundColor(.white)
                    }
                    .tint(.gray)
                    
                    
                    
                } //: VStack
            } //: ScrollView(.vertical)
            
            .navigationTitle("Summary") // Title
            .navigationBarTitleDisplayMode(.inline)
            
        } //: else
    } //: body
} //: SummaryView

    
// MARK: - SUMMARY BOX

// Format for each individual stat box
struct SummaryBoxView: View {
    
    var title: String
    var value: String
    
    
    var body: some View {
        
        // TITLE
        Text(title)
            .font(.system(size: 17))
            .font(.system(.title, design: .rounded)
                .lowercaseSmallCaps()
                  )
            .foregroundColor(.white)
        
        // TEXT
        Text(value)
            .font(.system(size: 25))
            .font(.system(.title, design: .rounded)
                .lowercaseSmallCaps()
                  )
            .foregroundColor(.accentColor)
        
        
        // DIVIDER
        Divider()
        
        
    } //: body
} //: SummaryBoxView


// MARK: - PREVIEW

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}

