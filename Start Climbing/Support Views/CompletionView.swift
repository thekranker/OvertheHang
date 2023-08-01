//
//  CompletionSheetView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct CompletionView: View {
    
    // MARK: - PROPERTY
    
    @Binding var isCompletionPresented: Bool
    @Binding var completedGrade: Int
    
    
    // MARK: - BODY
    
    var body: some View {
        
        VStack {
            Spacer()
            
            // COMPLETED GRADE
            Text("V" + String(completedGrade) + " Completed")
                .font(.system(size: 25))
                .font(.system(.headline)
                    .monospacedDigit()
                    .lowercaseSmallCaps())
            
            Spacer()
            
            
            // CHECKMARK
            CheckmarkView(isCompletionPresented: $isCompletionPresented)
            
            
            Spacer()
        } //: VStack
    } //: body
} //: CompletionView
