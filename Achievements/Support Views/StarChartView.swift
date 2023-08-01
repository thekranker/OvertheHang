//
//  StartChartView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/26/23.
//

import SwiftUI

struct StarChartView: View {
    
    // MARK: - PROPERTY
    
    @Environment(\.dismiss) var dismiss
    
    @State var goals: [Int] = [1, 5, 10, 25, 50, 100, 250, 500]
    @State var starColors: [Color] = [
        .white, .yellow, .customAqua, .green, .blue, .pink
    ]
    
    var legacyColors: [AngularGradient] = [
        gradients.silver.angularGradient,
        gradients.gold.angularGradient,
        gradients.rainbow.angularGradient
    ]
    
    
    // MARK: - GRADIENT
    
    enum gradients {
        case silver
        case gold
        case rainbow
        case legacy
        
        var colors: [Color] {
            switch self {
              
            case .silver: return [.gray, .white, .gray, .white,]
            case .gold: return [.white, .yellow, .white, .yellow,]
            case .rainbow: return [.customRed, .customGreen, .customBlue, .customPink]
            case .legacy: return [.brown, .white, .gray, .white, .yellow, .white]
                
            } //: switch
        } //: colors
        
        var angularGradient: AngularGradient {
            return AngularGradient(
                colors: self.colors,
                center: .center)
        } //: angularGradient
    } //: gradients
    
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical) {
            
            
            
            // TITLE
            Text("Star Chart")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            SeparatorView(color: .secondary)
            
            
            
            // STAR COLORS
            ForEach(0..<5) { index in
                HStack { // Star: Complete (Goal) Climbs
                    Image(systemName: "star.fill")
                        .foregroundColor(starColors[index])
                    Text("=  Complete \(goals[index]) Climbs")
                }
                .font(.system(size: 13))
                .frame(maxWidth: .infinity, alignment: .leading)
            } //: ForEach
            
            
            
            // LEGACY
            SeparatorView(color: .secondary)
            Text("Legacy")
                .foregroundColor(.secondary)
                .fontWeight(.semibold)
            Spacer()
            
            
            
            // LEGACY STAR COLORS
            ForEach(0..<3) { index in
                HStack { // Star: Complete (Goal) Climbs
                    Image(systemName: "star.fill")
                        .foregroundStyle(legacyColors[index])
                    Text("\(goals[index + 5]) Climbs")
                    Image(systemName: "star.fill")
                        .foregroundStyle(legacyColors[index])
                } //: HStack
                .font(.system(size: 14))
            } //: ForEach
            
            
            
            
        } //: ScrollView(.vertical)
    } //: body
} //: StarChartView


// MARK: - PREVIEW

struct StarChartView_Previews: PreviewProvider {
    static var previews: some View {
        StarChartView()
    }
}


