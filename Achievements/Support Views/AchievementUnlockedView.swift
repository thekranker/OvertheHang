//
//  AchievementUnlockedView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/27/23.
//

import SwiftUI

struct AchievementUnlockedView: View {
    
    // MARK: - PROPERTY
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedGrade: Int
    @Binding var gradeCount: Int
    
    @State var animationDuration = 10.0
    @State var achievementSize = 10
    
    
    @State var showingLock = false
    @State var descriptionHidden = true
    @State var dismissHidden = true
    @State var showingFireworks = false
    @State var showingText = false
    
    
    // MARK: - FUNCTION
    
    func animate() {
        
        // Unlock Animation
        withAnimation(
            .linear(duration: 0.03 * animationDuration)
            .delay(0 * animationDuration)) {
                showingLock = true
                achievementSize = 10
            }
        
        // Title
        withAnimation(
            .linear(duration: 0.01 * animationDuration)
            .delay(0.2 * animationDuration)) {
                achievementSize = 27
                showingLock = false
                showingFireworks = true
                showingText = true
            }
        
        // Description
        withAnimation(
            .linear(duration: 0.05 * animationDuration)
            .delay(0.3 * animationDuration)) {
                self.descriptionHidden.toggle()
        }
        
        // Done Button
        withAnimation(
            .linear(duration: 0.03 * animationDuration)
            .delay(0.55 * animationDuration)) {
                self.dismissHidden.toggle()
        }
                
    } //: animate()
    
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            
            
            ZStack {
                
                // UNLOCK ANIMATION
                if (showingLock) {
                    UnlockAnimationView()
                } //: if
                
                
                // FIREWORK ANIMATION
                if (showingFireworks) {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier())
                        .offset(x: -100, y : -50)
                    
                    Circle()
                        .fill(Color.red)
                        .frame(width: 12, height: 12)
                        .modifier(ParticlesModifier())
                        .offset(x: 60, y : 70)
                } //: if
            } //: ZStack
            
            
            
            
            // ACHIEVEMENT
            if (showingText) {
                Text("Achievement!")
                    .font(.system(size: CGFloat(achievementSize)))
                    .fontWeight(.semibold)
                    .foregroundColor(.cyan)
            } //: if
            
            
            
            // DESCRIPTION
            if (!descriptionHidden) {
                if (gradeCount == 1) {
                    Text("First V\(selectedGrade)!")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                } else {
                    Text("Finish \(gradeCount) V\(selectedGrade)'s!")
                        .foregroundColor(.secondary)
                        .fontWeight(.semibold)
                }
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
} //: AchievementUnlockedView


// MARK: - FIREWORKS

struct FireworkParticlesGeometryEffect : GeometryEffect {
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


struct ParticlesModifier: ViewModifier {
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation (.easeOut(duration: duration)) {
                    self.time = duration
                    self.scale = 1.0
                } 
            }
        }
    }
}
