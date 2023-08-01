//
//  Checkmark.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/27/23.
//

import Foundation
import SwiftUI

// MARK: - CHECKMARK

struct Checkmark: Shape {
    
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width // Width of checkmark
        let height = rect.size.height // Height of checkmark
    
        
        var path = Path() // Draws the checkmark
        path.move(to: .init(x: 0 * width, y: 0.5 * height))
        path.addLine(to: .init(x: 0.4 * width, y: 1.0 * height))
        path.addLine(to: .init(x: 1.0 * width, y: 0 * height))
        return path
        
        
    } //: Path
} // Checkmark

