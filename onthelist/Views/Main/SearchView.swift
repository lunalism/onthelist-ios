//
//  SearchView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 2025/04/19.
//

import SwiftUI
import NMapsMap
import CoreLocation

// MARK: - 네이버 지도 Wrapping UIViewRepresentable
struct NaverMapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        mapView.showLocationButton = true
        mapView.showZoomControls = true
        mapView.mapView.positionMode = .direction

        // ✅ 카메라를 사용자 위치로 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
        cameraUpdate.animation = .easeIn
        mapView.mapView.moveCamera(cameraUpdate)

        return mapView
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

// MARK: - 장소 구조체
struct Place: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let address: String
    let icon: String
}

// MARK: - SearchView 본문
struct SearchView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var searchText: String = ""
    @State private var showResults = false

    // 🔍 임시 더미 검색결과 (네이버 API 연동 전)
    private let places: [Place] = [
        Place(name: "커피빈 강남점", address: "서울 강남구 테헤란로", icon: "cup.and.saucer.fill"),
        Place(name: "이디야커피", address: "서울 종로구 종로", icon: "bolt.fill")
    ]

    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - 지도 (사용자 위치 기반)
            if let userLocation = locationManager.userLocation {
                NaverMapView(coordinate: userLocation)
                    .ignoresSafeArea(edges: .top)
                    .frame(maxWidth: .infinity, maxHeight: showResults ? UIScreen.main.bounds.height * 0.65 : .infinity)
                    .background(Color.white)
            } else {
                ProgressView(LocalizedStringKey("loading_location"))
            }

            // MARK: - 검색창 (상단 고정)
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField(
                        LocalizedStringKey("search.placeholder"),
                        text: $searchText,
                        onCommit: {
                            withAnimation {
                                showResults = !searchText.isEmpty
                            }
                        }
                    )
                    .foregroundColor(.primary)
                    .font(.system(size: 15)) // ✅ 폰트 크기 조절
                    .autocapitalization(.none)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.horizontal, 12)
                .shadow(radius: 3)
                .padding(.top, 20) // 노치 대응

                Spacer()
            }

            // MARK: - 검색결과 리스트
            if showResults {
                VStack {
                    Spacer()

                    // ✅ 배경과 콘텐츠를 분리하여 일치시키기
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.ultraThinMaterial)
                            .frame(maxWidth: .infinity)
                            .frame(height: CGFloat(places.prefix(5).count) * 68) // 대략 계산

                        VStack(spacing: 10) {
                            ForEach(places.prefix(5)) { place in
                                HStack(spacing: 12) {
                                    Image(systemName: place.icon)
                                        .font(.system(size: 20))
                                        .foregroundColor(.primary)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(place.name)
                                            .font(.system(size: 16, weight: .medium))
                                            .foregroundColor(.primary)

                                        Text(place.address)
                                            .font(.system(size: 13))
                                            .foregroundColor(.secondary)
                                    }

                                    Spacer()
                                }
                                .padding(.vertical, 8)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical, 16) // 내부 여백 확보
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5) // 탭바 간격 확보
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

#Preview {
    SearchView()
}
