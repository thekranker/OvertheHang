//
//  GymLocationsView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/9/23.
//

import SwiftUI

struct GymLocationsView: View {
    // MARK: - PROPERTY
    @State private var locations: [String] = [] // Stores a string of set locations
    @State private var text: String = "" // Text of "Add New Gym" TextField
    
    // MARK: - FUNCTION
    // Returns a URL type to store locations for local files stored on watch
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    // Saves set locations in "locations" array
    func save() {
//        dump(locations)
        
        do {
            // 1.) Convert the locations array to data using JSONEnconder
            let data = try JSONEncoder().encode(locations)
            
            // 2.) Create a new URL to save the file using the getDocumentDirectory
            let url = getDocumentDirectory().appendingPathComponent("locations")
            
            // 3.) Write the data to the given URL
            try data .write(to: url)
            
        } catch {
            print("Saving data has failed!")
        }
    }
    
    // Decodes the stored data
    func load() {
        // Tells the watch to run this code at the next possible opportunity that isn't right now
        // Ensures the app won't get confused and crash upon startup
        DispatchQueue.main.async {
            do {
                // 1.) Get the notes URL path
                let url = getDocumentDirectory().appendingPathComponent("locations")
                
                // 2.) Create a new property for the data
                let data = try Data(contentsOf: url)
                
                // 3.) Decode the data and assign its value to this property
                locations = try JSONDecoder().decode([String].self, from: data)
                
            } catch {
                // Do nothing
            }
        }
    }
    
    // Allows to Delete Set Gyms from "locations" array
    func delete(offsets: IndexSet) {
        withAnimation {
            locations.remove(atOffsets: offsets)
            save()
        }
    }
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 6) {
                TextField("Add New Gym", text: $text) // TextField to add a new gym
                Button { // Adds the typed out gym to "locations" array and updates "Known Gyms" counter
                    
                    // 1.) Only run button's action when text field isn't empty
                    guard text.isEmpty == false else { return }
                    
                    // 2.) Create a new location and initialize with text value
                    let location = String(text)
                    
                    // 3.) Add new location to locations array (append)
                    locations.append(location)
                    
                    // 4.) Make the text field empty
                    text = ""
                    
                    // 5.) Save the location (function)
                    save()
                    
                    
                } label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.teal) 
            } //: HSTACK
            
            Spacer()
            
            if locations.count >= 1 {
                List {
                    ForEach(0..<locations.count, id: \.self) { i in
                        HStack {
                            Capsule()
                                .frame(width: 4)
                                .foregroundColor(.teal)
                            Text(locations[i])
                                .lineLimit(1)
                                .padding(.leading, 5)
                        } //: HSTACK
                    } //: LOOP
                    .onDelete(perform: delete)
                }
            } else {
                Spacer()
                Image(systemName: "figure.climbing")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(15)
                Spacer()
            } //: LIST
        } //: VSTACK
        .onAppear(perform: {
            load()
        })
        .navigationTitle("Gyms")
        .navigationBarBackButtonHidden(false)
    }
}

// MARK: - PREVIEW
struct GymLocationsView_Previews: PreviewProvider {
    static var previews: some View {
        GymLocationsView()
    }
}
