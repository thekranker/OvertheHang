//
//  LegacyUnlockedView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/28/23.
//

import SwiftUI

struct LegacyUnlockedView: View {
    
    // MARK: - PROPERTY
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedGrade: Int
    @Binding var gradeCount: Int
    
    @State var duration = 10.0
    @State var textSize = 45
    
    @State var isGlowing = true
    @State var showingDesc = false
    @State var dismissHidden = true
    @State var showingFireworks = false
    
    @State var textColor = Color.red
    
    
    // MARK: - FUNCTION
    
    func animate() {
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0 * duration)) {
                textColor = Color.red
        }
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0.025 * duration)) {
                textColor = Color.orange
        }
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0.05 * duration)) {
                textColor = Color.yellow
        }
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0.075 * duration)) {
                textColor = Color.green
        }
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0.1 * duration)) {
                textColor = Color.blue
        }
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0.125 * duration)) {
                textColor = Color.customPink
        }
        
        withAnimation(
            .linear(duration: 0.025 * duration)
            .delay(0.15 * duration)) {
                textColor = Color.purple
        }
        
        withAnimation(
            .linear(duration: 0.01 * duration)
            .delay(0.175 * duration)) {
                textSize = 55
                textColor = Color.white
                showingDesc.toggle()
                showingFireworks.toggle()
        }
        
        withAnimation(
            .linear(duration: 0.01 * duration)
            .delay(0.185 * duration)) {
                textSize = 45
        }
        
        withAnimation(
            .linear(duration: 0.03 * duration)
            .delay(0.55 * duration)) {
                dismissHidden.toggle()
        }
        
    } //: animate()
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            
            ZStack {
                
                
                // FIREWORK ANIMATION
                if (showingFireworks) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier1())
                        .offset(x: -100, y : -50)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier1())
                        .offset(x: 60, y : 70)
                } //: if
            
            
            
            // LEGACY
                Text("Legacy")
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .font(.system(size: CGFloat(textSize)))
                    .blur(radius: isGlowing ? 15.0 : 0)
                
                Text("Legacy")
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                    .font(.system(size: CGFloat(textSize)))
            } //: ZStack
            
            
            
            // DESCRIPTION
            if (showingDesc) {
                Text("Finish \(gradeCount) V\(selectedGrade)'s!")
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            } //: if
            
            
            
            // DONE BUTTON
            if (!dismissHidden) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                    Spacer()
                } //: HStack
            } //: if
            
            
            
        } //: VStack
        
        .onAppear() {
            animate()
        }
        
    } //: body
} //: LegacyUnlockedView


// MARK: - FIREWORKS

struct FireworkParticlesGeometryEffect1 : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 20 ... 200)
    var direction = Double.random(in: -Double.pi ...  Double.pi)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * cos(direction) * time
        let yTranslation = speed * sin(direction) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct ParticlesModifier1: ViewModifier {
    @State var time = 0.0
    @State var scale = 0.1
    let duration = 5.0
    
    func body(content: Content) -> some View {
        ZStack {
            ForEach(0..<80, id: \.self) { index in
                content
                    .hueRotation(Angle(degrees: time * 80))
                    .scaleEffect(scale)
                    .modifier(FireworkParticlesGeometryEffect(time: time))
                    .opacity(((duration-time) / duration))
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.75) {
                withAnimation (.easeOut(duration: duration)) {
                    self.time = duration
                    self.scale = 1.0
                } //: DispachQueue
            }
        }
    }
}
