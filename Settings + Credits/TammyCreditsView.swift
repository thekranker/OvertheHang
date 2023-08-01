//
//  TammyCreditsView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct TammyCreditsView: View {
    
    // MARK: - BODY
    
    var body: some View {
        VStack(spacing: 3) {
            
            
            // TITLE
            Text("CREDITS".uppercased())
                .font(.title3)
                .fontWeight(.semibold)
            
            
            // SEPARATOR
            SeparatorView(color: .green)
            
            
            // CONTENT
            Text("Tamanna Kathuria")
                .fontWeight(.bold)
            
            Text("App Icon Designer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            
            
            // SEPARATOR
            SeparatorView(color: .orange)
            
            
        } //: VStack
    }
}


// MARK: - PREVIEW

struct TammyCreditsView_Previews: PreviewProvider {
    static var previews: some View {
        TammyCreditsView()
    }
}
