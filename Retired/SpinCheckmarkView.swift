//
//  SpinCheckmarkView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/27/23.
//

import SwiftUI

struct SpinCheckmarkView: View {
    
    // MARK: - PROPERTY
    
    @State private var buttonTransparency = 1
    @State private var showCircle = 0
    @State private var removeInnerFill = 1
    @State private var rotate3D = -180
    
    
    @State private var innerTrimEnd: CGFloat = 0
    var animationDuration: Double = 2.5
    
    
    // MARK: - FUNCTION
    
    func animate() {
        
        
        // Opening Animation
        withAnimation(.linear(duration: 0.2 * animationDuration)) {
            removeInnerFill  = 1
        }
        
        // Circle Spin Animation
        withAnimation(
            .linear(duration: 0.8 * animationDuration)
            .delay(0.2 * animationDuration)) {
            showCircle = 1
            buttonTransparency = 0
            removeInnerFill  = 4
            rotate3D = 180
        }
        
        
        // Checkmark Animation
        withAnimation(
            .linear(duration: 0.1 * animationDuration)
            .delay(0.8 * animationDuration)) {
                innerTrimEnd = 1.0
            }
    }
    
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            
            
            // CHECKMARK
            Checkmark()
                    .trim(from: 0, to: innerTrimEnd)
                    .stroke(.white, lineWidth: 7)
                    .frame(width: 50, height: 50)
                    .cornerRadius(1)

            
            
            // CIRCLE
            Circle()
                .strokeBorder(lineWidth: CGFloat(removeInnerFill))
                .frame(width: 100, height: 100)
                .foregroundColor(.mint)
                .rotation3DEffect(
                    .degrees(Double(rotate3D)),
                    axis: (x: 15, y: 15, z: 0.0))
                .animation(Animation.timingCurve(1.000, -0.600, 1.000, 1.63).speed(0.2).delay(0.25))
        } //: ZStack
        .onAppear() {
            animate()
        } //: onAppear
        
        
        
        
    } //: body
} //: SpinCheckmarkView

// MARK: - PREVIEW

struct SpinCheckmarkView_Previews: PreviewProvider {
    static var previews: some View {
        SpinCheckmarkView()
    }
}
