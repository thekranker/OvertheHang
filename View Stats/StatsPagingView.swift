//
//  StatsPagingView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/8/23.
//

import SwiftUI
import HealthKit

struct StatsPagingView: View {
    
// MARK: - PROPERTY
    
    @State private var selection: Tab = .latestSessionsView // Auto selects latestSessionsView() when displaying stats
    
    enum Tab { // Stores the various stat tabs
        case latestSessionsView, barChartView, avgGradeComparisonView
    }
    
    
// MARK: - BODY
    var body: some View {
        
        // TAB VIEW
        TabView(selection: $selection) { // "Swipe to switch tabs" format
            LatestSessionsView().tag(Tab.latestSessionsView)
            BarChartView().tag(Tab.barChartView)
            AvgGradeComparisonView().tag(Tab.avgGradeComparisonView)
        }
        
        
    } //: body
} //: StatsPagingView


// MARK: - PREVIEW

struct StatsPagingView_Previews: PreviewProvider {
    static var previews: some View {
        StatsPagingView()
    }
}
