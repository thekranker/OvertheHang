//
//  AvgGradeComparisonView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/22/23.
//

import SwiftUI
import Charts

struct AvgGradeComparisonView: View {
    
    // MARK: - PROPERTY

    // Array to store and display individual month stats by average grade
    let selectedSessionData: [sessionData] = [
        .init(month: "July", avgGradeClimbed: 3.7),
        .init(month: "June", avgGradeClimbed: 3.2),
        .init(month: "May", avgGradeClimbed: 2.9),
        .init(month: "April", avgGradeClimbed: 2.5),
    ]

    
    // Structure for the selectedSessionData Array to conform to
    struct sessionData: Identifiable {
        let id = UUID()
        let month: String
        let avgGradeClimbed: Double
    }
    
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            
            
            // TITLE
            Text("Avg Grade Comparison")

            
            
            // CHART
            Chart {
                
                // Goal
                RuleMark(x: .value("Goal", 3.5))
                    .foregroundStyle(.mint)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5]))
                    .annotation(position: .bottom) {
                        Text("   Goal")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                            .rotationEffect(Angle(degrees: 90))
                    }


                // July Bar Graph
                BarMark(
                    x: .value("AvgGrade", 3.9),
                    y: .value("Month", "This Month")
                )
                .foregroundStyle(Color.green.gradient)
                .cornerRadius(3)

                
                // June Bar Graph
                BarMark(
                    x: .value("AvgGrade", 3.5),
                    y: .value("Month", "June")
                )
                .foregroundStyle(Color.red.gradient)
                .cornerRadius(3)

                
                // May Bar Graph
                BarMark(
                    x: .value("AvgGrade", 3.1),
                    y: .value("Month", "May")
                )
                .foregroundStyle(Color.red.gradient)
                .cornerRadius(3)

                
                // April Bar Graph
                BarMark(
                    x: .value("AvgGrade", 2.9),
                    y: .value("Month", "April")
                )
                .foregroundStyle(Color.red.gradient)
                .cornerRadius(3)
                
                
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
} //: AvgGradeComparisonView


// MARK: - Preview

struct AvgGradeComparisonView_Previews: PreviewProvider {
    static var previews: some View {
        AvgGradeComparisonView()
    }
}
