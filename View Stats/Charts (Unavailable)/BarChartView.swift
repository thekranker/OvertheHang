//
//  BarChartView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/22/23.
//

import SwiftUI
import Charts

struct BarChartView: View {
    
    // MARK: - PROPERTY
    @EnvironmentObject var workoutManager: WorkoutManager
    

    // Array to store and display individual grade stats by count
    let viewGrades: [ViewGrade] = [
        .init(grade: "V0", gradeCount: 2),
        .init(grade: "V1", gradeCount: 1),
        .init(grade: "V2", gradeCount: 2),
        .init(grade: "V3", gradeCount: 7),
        .init(grade: "V4", gradeCount: 2),
        .init(grade: "V5", gradeCount: 1)
    ]
    
    
    // Structure for the "viewGrades" array to conform to
    struct ViewGrade: Identifiable {
        let id = UUID()
        let grade: String
        let gradeCount: Int
    }
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            
            
            // TITLE
            Text("All Time Grade Stats")

            
            
            // CHART
            Chart {
                ForEach(viewGrades) { viewGrade in
                    BarMark(
                        x: .value("Grade", viewGrade.grade),
                        y: .value("Count", viewGrade.gradeCount)
                    )
                    .foregroundStyle(Color.cyan.gradient)
                    .cornerRadius(3)
                } //: ForEach
            } //: Chart
            .chartXAxis {
                AxisMarks(position: .bottom) { _ in
                    AxisGridLine().foregroundStyle(.clear)
                    AxisTick().foregroundStyle(.clear)
                    AxisValueLabel()
                } //: AxisMarks
            } //: chartXAxis
            
            
            
        } //: VStack
    } //: body
} //: BarChartView


// MARK: - Preview

struct BarChartView_Previews: PreviewProvider {
    static var previews: some View {
        BarChartView()
    }
}

