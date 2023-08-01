//
//  FireworkView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/27/23.
//

import SwiftUI

struct FireworkView: View {
    
    // MARK: - PROPERTY
    
    @State var biggestSplash = false
    @State var showStroke = false
    @State var showFireworks = false
    @State var bigRotates = false
    @State var biggerAnimates = false
    @State var smallTrims = false
    
    let screenColor = Color(red: 0.0, green: 0.0, blue: 0.0)
    
    
    // MARK: - BODY
    
    var body: some View {
       
        
        // ACHIEVEMENT UNLOCKED
        ZStack {
            screenColor
                .scaleEffect(1.2)
            
            VStack {
                Text("Achievement Unlocked!")
                    .font(.title3)
                    .foregroundColor(.customAqua)
                Text("Complete 100 V0's")
                    .foregroundColor(.secondary)
            }
            
            
            
            
            ZStack {
                Circle() // Biggest
                    .strokeBorder(style: StrokeStyle(lineWidth: biggestSplash ? 1 : 50,
                                                     lineCap: .butt,
                                                     miterLimit: 1,
                                                     dash: [1, 20],
                                                     dashPhase: 1
                                                    ))
                    .frame(width: 350, height: 350)
                    .foregroundColor(.blue)
                    .animation(Animation.easeInOut(duration: 1).speed(1).delay(0.5).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.biggestSplash.toggle()
                    } //: onAppear
                
                
                
                Circle() // Bigger
                    .strokeBorder(style: StrokeStyle(lineWidth: biggerAnimates ? 1 : 20,
                                                     lineCap: .butt,
                                                     miterLimit: 1,
                                                     dash: [1, 20],
                                                     dashPhase: 1
                                                    ))
                    .frame(width: 250, height: 250)
                    .foregroundColor(.white)
                    .animation(Animation.easeInOut(duration: 1).speed(1).delay(0.5).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.biggerAnimates.toggle()
                    } //: onAppear
                
                
                
                Circle() // Big
                    .strokeBorder(style: StrokeStyle(lineWidth: 1,
                                                     lineCap: .round,
                                                     miterLimit: 1,
                                                     dash: [120, 120],
                                                     dashPhase: 1
                                                    ))
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)
                    .animation(Animation.easeInOut(duration: 1).speed(1).delay(0.5).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.bigRotates.toggle()
                    } //: onAppear
                
                
                
                Circle() // Small
                    .trim(from: smallTrims ? 0 : 1/9, to: smallTrims ? 1/9: 1)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                    .animation(Animation.easeInOut(duration: 1).speed(1).delay(0.5).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.smallTrims.toggle()
                    } //: onAppear
                
                
                
                Circle() // Smaller
                    .strokeBorder(style: StrokeStyle(lineWidth: showStroke ? 1 : 30))
                    .frame(width: 80, height: 80)
                    .foregroundColor(.white)
                    .animation(Animation.easeInOut(duration: 1).speed(1).delay(0.5).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.showStroke.toggle()
                    } //: onAppear
            } //: ZStack
            
            
            
            
            // FIREWORKS
            .scaleEffect(showFireworks ? 1 : 0, anchor: .bottomTrailing)
            .shadow(color: showFireworks ? .red : .pink,
                    radius: showFireworks ? -1 : 1,
                    x: 20,
                    y: 20
            )
            .rotation3DEffect(.degrees(70), axis: (x: -0.1, y: -0.5, z: 0))
            .animation(Animation.easeInOut(duration: 1).speed(1).delay(0.5).repeatForever(autoreverses: false))
            .onAppear() {
                self.showFireworks.toggle()
            } //: onAppear
            
            
            
        } //: ZStack
    } //: body
} //: FireworkView


// MARK: - PREVIEW

struct FireworkView_Previews: PreviewProvider {
    static var previews: some View {
        FireworkView()
    }
}
