//
//  SettingsView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/24/23.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - PROPERTY
    
    @State var isBouldering = true
    @State var notifications = false
    
    
    // MARK: - BODY
    
    var body: some View {
        ScrollView(.vertical) {
            
            
            
            // TITLE
            Text("Settings")
                .font(.system(size: 18))
                .foregroundColor(.gray)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
            SeparatorView(color: .gray)
            
            
            
            
            // CLIMB TYPE
            Text("Climb Type") // Title
                .fontWeight(.semibold)
            Text("Currently Unavailable")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            HStack {
                Button {
                    isBouldering.toggle() // Toggles isBouldering
                } label: {
                    Text("<")
                }
                .fixedSize()
                
                if (isBouldering) {
                    Button {
                    } label: {
                        Text("Bouldering") // Button text
                    }
                    .foregroundColor(.green)
                    .fontWeight(.semibold)
                } //: if
                else {
                    Button {
                    } label: {
                        Text("Top Rope") // Button text
                    }
                    .foregroundColor(.orange)
                    .fontWeight(.semibold)
                } //: else
                
                Button {
                    isBouldering.toggle() // Toggles isBouldering
                } label: {
                    Text(">")
                }
                .fixedSize()
            } // HStack
            
            
            
            Spacer()
                .frame(height: 15)
            
            
            
            
            // CONTACT US
            SeparatorView(color: .gray)
            
            Text("Contact Us ")
            
            
            Text("Currently Unavailable")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
            
            
                
            
            
            
            
            
        } //: ScrollView(.vertical)
    } //: body
} //: SettingsView


// MARK: - PREVIEW

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
