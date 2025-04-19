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
            NaverMapView()
                .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    SearchView()
}
