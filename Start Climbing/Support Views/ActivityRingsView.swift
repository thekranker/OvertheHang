//
//  ActivityRingsView.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 7/9/23.
//

import Foundation
import HealthKit
import SwiftUI

struct ActivityRingsView: WKInterfaceObjectRepresentable {
    
    // MARK: - PROPERTY
    
    let healthStore: HKHealthStore
    
    
    // MARK: - FUNCTION
    
    func updateWKInterfaceObject(_ wkInterfaceObject: WKInterfaceObjectType, context: Context) {
    }
    

    // DECLARES ACTIVITY RING OBJECT
    func makeWKInterfaceObject(context: Context) -> some WKInterfaceObject {
        
        let activityRingsObject = WKInterfaceActivityRing()
        
        
        // Date components for activity ring summary
        let calendar = Calendar.current
        var components = calendar.dateComponents([.era, .year, .month, .day], from: Date())
        
        
        components.calendar = calendar
        
        
        let predicate = HKQuery.predicateForActivitySummary(with: components) // Date components
 
        
        // Sets activity ring summary on activity ring object on main queue
        let query = HKActivitySummaryQuery(predicate: predicate) { query,
            summaries, error in
            DispatchQueue.main.async {
                activityRingsObject.setActivitySummary(summaries?.first, animated: true)
            } //: DispatchQueue
        } //: query
        
        
        healthStore.execute(query) // Execute the query on the HKHealthStore
        
        
        
        return activityRingsObject // Returns the activityRingsObject
         
    } //: makeWKInterfaceObject
} //: ActivityRingsView
