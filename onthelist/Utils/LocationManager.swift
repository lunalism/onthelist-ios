//
//  LocationManager.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()

    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else { return }
        userLocation = coordinate
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 가져오기 실패: \(error.localizedDescription)")
    }
}
