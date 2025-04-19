//
//  ContentView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct NaverMapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()

        // 기본 설정
        mapView.showLocationButton = true
        mapView.showZoomControls = true
        mapView.mapView.positionMode = .direction

        // ✅ 사용자 위치로 카메라 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
        cameraUpdate.animation = .easeIn
        mapView.mapView.moveCamera(cameraUpdate)

        return mapView
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // 필요시 지도 갱신
    }
}

struct SearchView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchText: String = ""

    var body: some View {
        ZStack {
            if let userLocation = locationManager.userLocation {
                NaverMapView(coordinate: userLocation)
                    .ignoresSafeArea(.all, edges: .top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            } else {
                ProgressView("사용자 위치를 불러오는 중...")
            }
            
            // 2. 상단 검색창
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("어떤 리뷰를 찾고 계신가요?", text: $searchText)
                        .foregroundColor(.primary)
                        .autocapitalization(.none)
                }
                .padding()
                .padding(.horizontal, 6)
                .padding(.vertical, -6)
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal, 10)
                .shadow(radius: 3)

                Spacer() // 화면 아래로 밀기 위한 spacer
            }
            .padding(.top, 8) // 상단 여백 (노치 고려)
        }
    }
}
#Preview {
    SearchView()
}
