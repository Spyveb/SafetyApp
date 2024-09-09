//
//  LocationManager.swift
//  Health Moniter Watch Watch App
//
//  Created by Mobilions iOS on 04/09/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil
    @Published var city = ""
    @Published var locationName = ""
    
    override init() {
        super.init()
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    private func checkLocationAuthorization() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            debugPrint("Location access denied or restricted.")
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
        @unknown default:
            debugPrint("Unknown authorization status.")
        }
    }
    
    func startLocationUpdates() {
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            DispatchQueue.main.async {
                self.location = newLocation
                self.reverseGeocode(location: newLocation)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint("Failed to get location: \(error.localizedDescription)")
    }
    
    func requestLocationAuthorization(completion: @escaping (CLAuthorizationStatus) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let status = CLLocationManager.authorizationStatus()
            completion(status)
        }
    }
    
    func reverseGeocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                debugPrint("Geocoding error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first {
                self.city = placemark.locality ?? ""
                self.locationName = self.formatAddress(from: placemark)
            }
        }
    }
    
    private func formatAddress(from placemark: CLPlacemark) -> String {
            var address = ""
            if let name = placemark.name {
                address += name + ", "
            }
            if let locality = placemark.locality {
                address += locality + ", "
            }
            if let administrativeArea = placemark.administrativeArea {
                address += administrativeArea + ", "
            }
            if let country = placemark.country {
                address += country
            }
            return address
        }
    
    func requestLocationAuthorizationWithDispatch() {
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let status = CLLocationManager.authorizationStatus()
            debugPrint("Authorization status after delay: \(status)")
            switch status {
            case .notDetermined:
                debugPrint("Authorization status not determined")
            case .restricted:
                debugPrint("Authorization status restricted")
            case .denied:
                debugPrint("Authorization status denied")
            case .authorizedAlways, .authorizedWhenInUse:
                debugPrint("Location access granted")
                self.startLocationUpdates()
            @unknown default:
                debugPrint("Unknown authorization status.")
            }
        }
    }
}
