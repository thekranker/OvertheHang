//
//  AddClimbView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/8/23.
//

import SwiftUI
import WatchKit

struct AddClimbView: View {
    
    // MARK: - PROPERTY
    
    @EnvironmentObject var workoutManager: WorkoutManager
    
    @State var isCompletionPresented = false
    @State var isAchievementUnlocked = false
    @State var isLegacyUnlocked = false
    
    @State private var selectedGrade = 0 // Index of picker's selection
    @State var completedGrade = 0
    @State var gradeCount = 0
    
    @State var goals = [1, 5, 10, 25, 50]
    @State var legacy = [100, 250, 500]
    
 
    // List for picker to scroll through
    let gradeList = ["V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10"]
    
    
// MARK: - BODY
    
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
                .frame(height: 25)
            
            
            
            // PICKER
            Picker("", selection: $selectedGrade) { // Select a grade
                ForEach(0..<gradeList.count) { index in
                    Text(gradeList[index])
                        .font(.system(size: 65, weight: .medium))
                } //: ForEach
            } //: Picker
            .focusBorderHidden()
            .defaultWheelPickerItemHeight(82)
            .pickerStyle(.wheel)
            .frame(height: 115)
            
            
            
            
            
            // BUTTON
            HStack {
                Spacer()
                    .frame(height: 5)
                Button { // Stores selected climb in the "metadataDictionary" in WorkoutManager
                    workoutManager.storeClimbData(climbGrade: selectedGrade)
                    
                    completedGrade = selectedGrade
                    
                    let gradeCount = workoutManager.stats[selectedGrade] + workoutManager.metadataDictionary["V\(selectedGrade)"]!
                    self.gradeCount = gradeCount
                    
                    
                    if (goals.contains(gradeCount)) { // Displays achievment if complete
                        isAchievementUnlocked.toggle()
                    } else if (legacy.contains(gradeCount)) {
                        isLegacyUnlocked.toggle()
                    } else {
                        isCompletionPresented.toggle() // Else, displays completion sheet
                    }
                    
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 25))
                }
                Spacer()
                    .frame(height: 5)
            } //: HStack
            
            
            
            
                        
            
                Spacer()
                    .frame(height: 15)
        } //: VStack
        .onAppear() {
            workoutManager.retrieveWorkouts() // Retrieves workout data
        } //: onAppear
        
        .sheet(isPresented: $isCompletionPresented, content: { // Displays completion sheet
            CompletionView(isCompletionPresented: $isCompletionPresented, completedGrade: $completedGrade)
                .navigationBarHidden(true)
        })
        .sheet(isPresented: $isAchievementUnlocked, content: { // Displays achievement unlocked sheet
            AchievementUnlockedView(selectedGrade: $selectedGrade, gradeCount: $gradeCount)
                .navigationBarHidden(true)
        })
        .sheet(isPresented: $isLegacyUnlocked, content: { // Displays legacy unlocked sheet
            LegacyUnlockedView(selectedGrade: $selectedGrade, gradeCount: $gradeCount)
                .navigationBarHidden(true)
        })
        
        
        
           
    } //: body
} //: AddClimbView


// MARK: - EXTENSION

extension Picker {
    
    // Hides the border of the picker
    func focusBorderHidden() -> some View {
        let isWatchOS7: Bool = {
            if #available(watchOS 7, *) {
                return true
            }

            return false
        }()

        let padding: EdgeInsets = {
            if isWatchOS7 {
                return .init(top: 17, leading: 0, bottom: 0, trailing: 0)
            }

            return .init(top: 8.5, leading: 0.5, bottom: 8.5, trailing: 0.5)
        }()

        return self
            .overlay(
                RoundedRectangle(cornerRadius: isWatchOS7 ? 8 : 7)
                    .stroke(Color.black, lineWidth: isWatchOS7 ? 4 : 3.5)
                    .offset(y: isWatchOS7 ? 0 : 8)
                    .padding(padding)
            )
    } //: focusBorderHidden()
} //: Picker


// MARK: - PREVIEW

struct AddClimbView_Previews: PreviewProvider {
    static var previews: some View {
        AddClimbView()
    }
}

