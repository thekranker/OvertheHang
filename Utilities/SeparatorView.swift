//
//  BorderView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct SeparatorView: View {
    
    // MARK: - PROPERTY
    
    var color: Color
    
    
    // MARK: - BODY
    
    var body: some View {
        HStack {
            
            Capsule()
                .frame(height: 1)
                .foregroundColor(color)
            
            Image(systemName: "figure.climbing")
            
            Capsule()
                .frame(height: 1)
                .foregroundColor(color)
        }
    }
}


// MARK: - PREVIEW

struct SeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        SeparatorView(color: .green)
    }
}
