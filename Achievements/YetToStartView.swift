//
//  YetToStartView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/25/23.
//

import SwiftUI

struct YetToStartView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    @State var progressValue: Float = 0.05
    
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical) {
            
            
            
            // TITLE
            Text("Yet to Start")
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            SeparatorView(color: .gray)
            
            
            
            
            // CONTENT
            ForEach(0..<11) { grade in
                let gradeCount = workoutManager.stats[grade] + (workoutManager.metadataDictionary["V\(grade)"] ?? 0)
                
                if (gradeCount == 0) {
                    
                    HStack {
                        Text("V\(grade)") // Displays grade if its count is 0
                            .fontWeight(.semibold)
                        ZStack {
                            ProgressBarView(value: progressValue) // Grade Progress Bar
                            Text("0/1")
                        } //: ZStack
                    } //: HStack
                    
                    Spacer()
                        .frame(height: 15)
                } //: if
            } //: ForEach
            
            
            
            
        } //: ScrollView(.vertical)
        
        .onAppear() {
            workoutManager.retrieveWorkouts()
        }
        
    } //: body
} //: YetToStartView


// MARK: - PREVIEW

struct YetToStartView_Previews: PreviewProvider {
    static var previews: some View {
        YetToStartView()
    }
}
