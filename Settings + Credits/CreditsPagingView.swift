//
//  CreditsPagingView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct CreditsPagingView: View {
    
    // MARK: - PROPERTY
    
    @State private var selection: Tab = .karanCreditsView // Selects KaranCreditsView() upon appearance
    
    enum Tab { // Stores the two credit tabs
        case karanCreditsView, tammyCreditsView
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        
        // TAB VIEW
        TabView(selection: $selection) { // "Swipe to switch tabs" format
            KaranCreditsView().tag(Tab.karanCreditsView)
            TammyCreditsView().tag(Tab.tammyCreditsView)
        } //: TabView
        
        
    } //: body
} //: CreditsPagingView


// MARK: - PREVIEW

struct CreditsPagingView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsPagingView()
    }
}
