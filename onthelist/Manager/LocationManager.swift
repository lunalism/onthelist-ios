//
//  LocationManager.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import Foundation
import CoreLocation
import SwiftUI

final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var userLocation: CLLocationCoordinate2D? = nil
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // 위치 권한 요청
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // 위치 권한 상태 변경 시
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }

    // 위치 업데이트 시 호출
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 🔥 강제 서울 위치로 설정 (시뮬레이터용)
        let seoulCoordinate = CLLocationCoordinate2D(latitude: 37.5665, longitude: 126.9780)
        userLocation = seoulCoordinate
        print("✅ 강제 위치 설정됨: \(seoulCoordinate)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("❌ 위치 가져오기 실패: \(error.localizedDescription)")
    }
}
