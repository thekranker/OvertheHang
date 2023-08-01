//
//  ContentViewModel.swift
//  Over the Hang Watch App
//
//  Created by Karan Kathuria on 6/7/23.
//

import CoreLocation
// MARK: - PROPERTY
// Array to store all known gym locations
var locationList: [CLLocationCoordinate2D] = [
    CLLocationCoordinate2D(latitude: 37.4026563376767, longitude: -122.1334165035671) // Gunn High School
    //CLLocationCoordinate2D(latitude: 37.41784194361671, longitude: -122.11327661533977) // Home
]


// Stores important location constants
enum LocationDetails {
    static let yosemiteLocation = CLLocationCoordinate2D(latitude: 37.87594185942118, longitude: -119.53832940000001)
    static let distanceThreshold = 75.0 // 75 Meters (245 Feet)
}


// This class encapsulates all the location related logic
// Checks for location permissions from the user
// Fetches current location
// Contains a function to compare against target location(s)
final class ContentViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var currentLoc = LocationDetails.yosemiteLocation // Variable to hold current location
    var locationManager: CLLocationManager?
    
    // MARK: - FUNCTIONS
    // Checks if location services is enabled on phone, if so, creates a CLLocationManager
    func initializeLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager!.delegate = self
        }
    }
    
    // Determines app's current location authorization status, prompting the user to turn on location services if needed
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted, likely due to parental controls.")
            case .denied:
                print("You have denied this app location permission. Go to settings to change it.")
            case .authorizedAlways, .authorizedWhenInUse:
                currentLoc = CLLocationCoordinate2D(
                    latitude: locationManager.location!.coordinate.latitude,
                    longitude: locationManager.location!.coordinate.longitude)
            @unknown default:
                break
        }
    }
    
    
    // If changes in app authorization are detected, makes a call to checkLocationAuthorization()
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    // Determines whether current location is close to any known gyms
    // Closeness determined by a set distanceThreshold
    func isLocationNearGym() -> Bool {
        let from = CLLocation(latitude: currentLoc.latitude, longitude: currentLoc.longitude)
        for location in locationList {
            let to = CLLocation(latitude: location.latitude, longitude: location.longitude)
            if from.distance(from: to) <= LocationDetails.distanceThreshold {
                return true
            }
        }
        return false
    }
}
