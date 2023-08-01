//
//  KaranCreditsView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct KaranCreditsView: View {
    
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
            Text("Karan Kathuria")
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            
            Text("github.com/thekranker")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            
            
            // SEPARATOR
            SeparatorView(color: .orange)
            
            
        } //: VStack
    }
}


// MARK: - PREVIEW

struct KaranCreditsView_Previews: PreviewProvider {
    static var previews: some View {
        KaranCreditsView()
    }
}
