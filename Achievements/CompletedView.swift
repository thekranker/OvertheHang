//
//  CompletedView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/25/23.
//

import SwiftUI

struct CompletedView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State var isStarChartPresented = false
    
    let goals: [Int] = [1, 5, 10, 25, 50, 100, 250, 500]
    let starColors: [Color] = [.white, .yellow, .customAqua, .green, .blue]
    
    let legacyColors: [AngularGradient] = [
        gradients.silver.angularGradient,
        gradients.gold.angularGradient,
        gradients.rainbow.angularGradient
    ]
    
    
    // MARK: - GRADIENT
    
    enum gradients {
        case silver
        case gold
        case rainbow
        case legacy
        
        var colors: [Color] {
            switch self {
              
            case .silver: return [.gray, .white, .gray, .white,]
            case .gold: return [.white, .yellow, .white, .yellow,]
            case .rainbow: return [.customRed, .customGreen, .customBlue, .customPink]
            case .legacy: return [.brown, .white, .gray, .white, .yellow, .white]
                
            } //: switch
        } //: colors
        
        var angularGradient: AngularGradient {
            return AngularGradient(
                colors: self.colors,
                center: .center)
        } //: angularGradient
    } //: gradients
    
    
    // MARK: - FUNCTION
    
    func findClosestGoal(number: Int) -> Int {
        var i = 0
        while (number >= goals[i]) {
            i += 1
        } //: while
        return i
    } //: findClosestGoal
    
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical) {

                
                
                // TITLE
                Text("Completed")
                    .font(.system(size: 18))
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                SeparatorView(color: .green)
                
                
                
                
                // CONTENT
                ForEach(0..<11) { grade in
                    let gradeCount = workoutManager.stats[grade] + (workoutManager.metadataDictionary["V\(grade)"] ?? 0)
                    let goal = findClosestGoal(number: gradeCount)
                    
                    if (gradeCount > 0) { // Only completed grades show up
                        HStack {
                            
                            if (goal < 5) { // Ensures the star isn't legacy
                                Button {
                                } label: {
                                    Text("V\(grade)")
                                        .fontWeight(.semibold)
                                }
                                .fixedSize()
                                ForEach(0..<goal) { star in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(starColors[star])
                                } //: ForEach
                            } else { // If the star is legacy
                                Image(systemName: "star.fill")
                                    .foregroundStyle(legacyColors[goal - 5])
                                Text("Legacy")
                                    .fontWeight(.heavy)
                                    .foregroundStyle(gradients.legacy.angularGradient)
                                Image(systemName: "star.fill")
                                    .foregroundStyle(legacyColors[goal - 5])
                            }
                            
                        } //: HStack
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                    } //: if (gradeCount > 0)
                } //: ForEach

            
            
        
                // STAR CHART
                SeparatorView(color: .secondary)
                HStack {
                    Spacer()
                    Button {
                        isStarChartPresented.toggle()
                    } label: {
                        Text("View Star Chart")
                    }
                    Spacer()
                } //: HStack
                .sheet(isPresented: $isStarChartPresented) {
                    StarChartView()
                }
                
                
            
                
        } //: ScrollView(.vertical)
        
        .onAppear() {
            workoutManager.retrieveWorkouts()
        }
        
    } //: body
} //: CompletedView


// MARK: - PROPERTY

struct CompletedView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedView()
    }
}
