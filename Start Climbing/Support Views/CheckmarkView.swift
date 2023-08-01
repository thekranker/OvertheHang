//
//  AnimatedCheckmarkView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct CheckmarkView: View {
    
    // MARK: - PROPERTY
    
    @Binding var isCompletionPresented: Bool
    
    @State private var innerTrimEnd: CGFloat = 0
    @State private var outerTrimEnd: CGFloat = 0
    @State private var strokeColor = Color.blue
    @State private var scale = 1.0
    
    var animationDuration: Double = 0.75
    
    
    // MARK: - FUNCTION
    
    func animate() { // Animates checkmark
        
        // Outer circle animation duration
        withAnimation(.linear(duration: 0.4 * animationDuration)) {
            outerTrimEnd = 1.0
        }
        
        // Inner checkmark animation duration
        withAnimation(
            .linear(duration: 0.3 * animationDuration)
            .delay(0.4 * animationDuration)
        ) {
            innerTrimEnd = 1.0
        }
        
        // Upscaling + Color change duration
        withAnimation(
            .linear(duration: 0.2 * animationDuration)
            .delay(0.7 * animationDuration)
        ) {
            strokeColor = .green
            scale = 1.1
        }
        
        // Downscaling duration
        withAnimation(
            .linear(duration: 0.1 * animationDuration)
            .delay(0.9 * animationDuration)
        ) {
            scale = 1
        }
        
    } //: animate
    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            
            
            // CIRCLE
            Circle()
                .trim(from: 0.0, to: outerTrimEnd)
                .stroke(strokeColor, lineWidth: 6)
                .rotationEffect(.degrees(-90))
            
            
            // CHECKMARK
            Checkmark()
                    .trim(from: 0, to: innerTrimEnd)
                    .stroke(strokeColor, lineWidth: 6)
                    .frame(width: 30, height: 30)
            
        } //: ZStack
        .scaleEffect(scale)
        .frame(width: 75, height: 75)
        
        
        .onAppear() { // Animates the checkmark upon appearance
            animate()
            let timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { (timer) in
                isCompletionPresented.toggle()
            }
        } //: onAppear
        
        
    } //: body
} //: CheckmarkView

