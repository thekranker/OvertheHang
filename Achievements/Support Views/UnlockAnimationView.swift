//
//  TestUnlockAnimationView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/28/23.
//

import SwiftUI
import Foundation
import UIKit

struct UnlockAnimationView: View {
    
    // MARK: - PROPERTY
    
    @State var duration = 10.0
    @State var rotate3D = -180
    
    @State var showingLock = true
    @State var showingUnlock = false
    @State var showingCircle = false
    
    
    
    // MARK: - FUNCTION
    
    func animate() {
        
        
        withAnimation(
            .linear(duration: 0.5 * duration)) {
            showingLock = true
            rotate3D = 600
        }
        
        withAnimation(
            .linear(duration: 0.01 * duration)
            .delay(0.2 * duration)) {
            showingLock = false
                showingUnlock = true
        }
        
        
    } //: animate
    
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            
            
            if (showingLock) {
                Image(systemName: "lock.fill")
                    .rotationEffect(.degrees(-90))
                    .font(.system(size: 90))
                    .rotation3DEffect(
                        .degrees(Double(rotate3D)),
                        axis: (x: 15, y: 15, z: 0.0))
                    .animation(Animation.timingCurve(1.000, -0.600, 1.000, 1.63).speed(0.2).delay(0.25))
            } //: if
            
            
            if (showingUnlock) {
                Image(systemName: "lock.open.fill")
                    .font(.system(size: 90))
            } //: if
            
            
            
            
            
        } //: ZStack
        .onAppear() {
            animate()
        }
        
    } //: body
} //: UnlockAnimationView


// MARK: - PREVIEW

struct UnlockAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        UnlockAnimationView()
    }
}


