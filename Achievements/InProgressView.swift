//
//  InProgressView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/25/23.
//

import SwiftUI

struct InProgressView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    
    @State var progressValue: Float = 0.05
    @State var goals: [Int] = [1, 5, 10, 25, 50, 100, 250, 500, 1000]
    
    
    // MARK: - FUNCTION
    
    func findClosestGoal(number: Int) -> Int {
        var i = 0
        while (number >= goals[i]) {
            i += 1
        } //: while
        return goals[i]
    } //: findClosestGoal
    
    
    func setProgressValue(climbCount: Int) -> Float {
        return Float(climbCount) / Float(findClosestGoal(number: climbCount))
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical) {
            
            
            
            // TITLE
            Text("In Progress")
                .font(.system(size: 18))
                .foregroundColor(.orange)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            SeparatorView(color: .orange)
            
            
            
            // CONTENT
            ForEach(0..<11) { grade in
                let gradeCount = workoutManager.stats[grade] + (workoutManager.metadataDictionary["V\(grade)"] ?? 0)
                
                if (gradeCount != 0 && gradeCount < 500) {
                    HStack {
                        Text("V\(grade)")
                            .fontWeight(.semibold)
                        ZStack {
                            ProgressBarView(value: setProgressValue(climbCount: gradeCount))
                            Text("\(gradeCount)/\(findClosestGoal(number: gradeCount))")
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
} //: InProgressView


// MARK: - PREVIEW

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        InProgressView()
    }
}
