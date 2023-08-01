//
//  AchievementPagingView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/25/23.
//

import SwiftUI

struct AchievementsPagingView: View {
    
    // MARK: - PROPERTY
    
    @State private var selection: Tab = .inProgressView // Selects InProgressView() upon appearance
    
    enum Tab { // Stores the three achievement tabs
        case completedView, inProgressView, yetToStartView
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        
        // TAB VIEW
        TabView(selection: $selection) { // "Swipe to switch tabs" format
            CompletedView().tag(Tab.completedView)
            InProgressView().tag(Tab.inProgressView)
            YetToStartView().tag(Tab.yetToStartView)
        } //: TabView
    } //: body
} //: AchievementsPagingView


// MARK: - PREVIEW

struct AchievementsPagingView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsPagingView()
    }
}
