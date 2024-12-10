//
//  LocaitionManager.swift
//  Cinerama Maps
//
//  Created by Techimmense Software Solutions on 02/09/24.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
    func didEnterInCircularArea()
    func didExitCircularArea()
}

class LocationManager: NSObject,CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation? = CLLocation.init(latitude: 22.7196, longitude: 75.8577)
    var delegate: LocationManagerDelegate?
    
    static let sharedInstance:LocationManager = {
        let instance = LocationManager()
        return instance
    }()
    
    override init() {
        super.init()
        self.locationManager = CLLocationManager()
        guard let locationManagers=self.locationManager else {
            return
        }
//        if CLLocationManager.authorizationStatus() == .notDetermined {
//            locationManagers.requestAlwaysAuthorization()
////            locationManagers.requestWhenInUseAuthorization()
//        }
//        if #available(iOS 9.0, *) {
//            //            locationManagers.allowsBackgroundLocationUpdates = true
//        } else {
//            // Fallback on earlier versions
//        }
        locationManager?.requestAlwaysAuthorization()
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.pausesLocationUpdatesAutomatically = false
        locationManagers.distanceFilter = 0.1
        locationManagers.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.lastLocation = location
        updateLocation(currentLocation: location)
    }
    
    @nonobjc func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager?.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        self.locationManager?.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
    func startMonitoringRegion(_ region: CLCircularRegion) {
        self.locationManager?.startMonitoring(for: region)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Enter in User's Proximity")
        self.delegate?.didEnterInCircularArea()
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exit from User's Proximity")
        self.delegate?.didExitCircularArea()
    }
    
    // #MARK:   get the alarm time from date and time
}
 
