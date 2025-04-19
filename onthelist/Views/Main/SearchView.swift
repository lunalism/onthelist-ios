//
//  ContentView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView = NMFNaverMapView()
        mapView.showLocationButton = true
        mapView.showZoomControls = true
        mapView.mapView.positionMode = .direction
        return mapView
    }

    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {}
}

struct SearchView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            // 전체 배경을 네이버 지도
            NaverMapView()
                .ignoresSafeArea(.all, edges: .top)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white) // 지도 아래 배경도 설정 (안 보일 경우 대비)
            
            // 하단 탭 메뉴는 MainTabView가 표시해줌
        }
    }
}

#Preview {
    SearchView()
}
