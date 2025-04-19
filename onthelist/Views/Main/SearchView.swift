//
//  SearchView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI
import NMapsMap
import CoreLocation

// MARK: - 네이버 지도 UIView 래퍼
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

// MARK: - 메인 검색 화면
struct SearchView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchText: String = ""

    var body: some View {
        ZStack {
            // 지도 뷰
            if let userLocation = locationManager.userLocation {
                NaverMapView(coordinate: userLocation)
                    .ignoresSafeArea(.all, edges: .top)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
            } else {
                ProgressView("loading.user.location")
            }

            // 상단 검색창
            VStack {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField(
                        LocalizedStringKey("search.placeholder"), // ✅ 시스템 언어에 따라 변환됨
                        text: $searchText
                    )
                    .font(.system(size:14))
                    .foregroundColor(.primary)
                    .autocapitalization(.none)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.horizontal, 10)
                .shadow(radius: 3)

                Spacer() // 아래로 밀기
            }
            .padding(.top, 10) // 노치 대응
        }
        .ignoresSafeArea(.keyboard) // 키보드 올라올 때 화면 뒤로 안 밀리게
    }
}

#Preview {
    SearchView()
}
