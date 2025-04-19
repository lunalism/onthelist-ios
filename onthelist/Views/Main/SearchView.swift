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

        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coordinate.latitude, lng: coordinate.longitude))
        cameraUpdate.animation = .easeIn
        mapView.mapView.moveCamera(cameraUpdate)

        return mapView
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

// MARK: - 검색 뷰
struct SearchView: View {
    @StateObject private var locationManager = LocationManager()
    @StateObject private var viewModel = SearchViewModel()
    @State private var searchText: String = ""

    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - 지도 표시
            if let coordinate = locationManager.userLocation {
                NaverMapView(coordinate: coordinate)
                    .ignoresSafeArea(edges: .top)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: viewModel.places.isEmpty ? .infinity : UIScreen.main.bounds.height * 0.65
                    )
                    .background(Color.white)
            } else {
                ProgressView(LocalizedStringKey("loading_location"))
            }

            // MARK: - 검색 입력창
            VStack(spacing: 0) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField(
                        LocalizedStringKey("search.placeholder"),
                        text: $searchText,
                        onCommit: {
                            // 검색 실행
                            if !searchText.isEmpty, let userCoordinate = locationManager.userLocation {
                                viewModel.searchPlaces(query: searchText, coordinate: userCoordinate)
                            }
                        }
                    )
                    .foregroundColor(.primary)
                    .font(.system(size: 15))
                    .autocapitalization(.none)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 8)
                .background(Color.white)
                .cornerRadius(14)
                .padding(.horizontal, 12)
                .shadow(radius: 3)
                .padding(.top, 20)

                Spacer()
            }

            // MARK: - 검색 결과 리스트
            if !viewModel.places.isEmpty {
                VStack {
                    Spacer()

                    VStack(spacing: 10) {
                        ForEach(viewModel.places.prefix(5)) { place in
                            HStack(spacing: 12) {
                                Image(systemName: "mappin.circle.fill")
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
                            .padding(.vertical, 6)
                            .padding(.horizontal)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .padding(.bottom, 8) // 탭바와 거리 확보
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

#Preview {
    SearchView()
}
