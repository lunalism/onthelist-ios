//
//  SearchViewModel.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 2025/04/19.
//

import Foundation
import CoreLocation

final class SearchViewModel: ObservableObject {
    @Published var places: [Place] = []
    @Published var showResults: Bool = false

    func searchPlaces(query: String, coordinate: CLLocationCoordinate2D) {
        PlaceSearchService.shared.searchPlaces(keyword: query, coordinate: coordinate) { [weak self] places in
            DispatchQueue.main.async {
                self?.places = places
                self?.showResults = !places.isEmpty
            }
        }
    }
}
