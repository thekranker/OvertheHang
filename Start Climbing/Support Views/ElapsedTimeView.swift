//
//  ElapsedTimeView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/11/23.
//

import SwiftUI

struct ElapsedTimeView: View {
    
    // MARK: - PROPERTY
    
    @State private var timeFormatter = ElapsedTimeFormatter()
    
    var elapsedTime: TimeInterval = 0
    var showSubseconds: Bool = true
    
    
    // MARK: - BODY
    
    var body: some View {
        Text(NSNumber(value: elapsedTime), formatter: timeFormatter)
            .fontWeight(.semibold)
            .onChange(of: showSubseconds) {
                timeFormatter.showSubseconds = $0
            } //: onChange
    } //: body
} //: ElapsedTimeView


// MARK: - CLASS

class ElapsedTimeFormatter: Formatter {
    
    let componentsFormmater: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()
    
    
    var showSubseconds = true
    
    
    override func string(for value: Any?) -> String? {
        
        guard let time = value as? TimeInterval else {
            return nil
        } //: guard
        
        guard let formattedString =
                componentsFormmater.string(from: time) else {
            return nil
        } //: guard
        
        return formattedString
    } //: override
} //: Class

// MARK: - PREVIEW

struct ElapsedTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ElapsedTimeView()
    }
}
