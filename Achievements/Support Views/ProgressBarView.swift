//
//  ProgressBarView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/25/23.
//

import SwiftUI

struct ProgressBarView: View {
    
    // MARK: - PROPERTY
    
    @State var value: Float
    
    
    // MARK: - BODY
    
    var body: some View {
        GeometryReader { geometry in
            
            
            ZStack(alignment: .leading) {
                
                
                // OUTER DEFAULT BAR
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(.teal)
                
                
                // INNER COMPLETION BAR
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width),
                                  height: geometry.size.height)
                .foregroundColor(.customBlue) // Color of Inner Bar
                .animation(.linear, value: value)
                
                
            } //: ZStack
            .cornerRadius(45.0)
            
            
            
            
        } //: GeometryReader
    } //: body
} //: ProgressBarView


// MARK: - PREVIEW

//struct ProgressBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressBarView()
//    }
//}
