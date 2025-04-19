//
//  PlaceSearchService.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 2025/04/19.
//

import Foundation
import CoreLocation

final class PlaceSearchService {
    static let shared = PlaceSearchService()

    private let baseURL = "https://openapi.naver.com/v1/search/local.json"
    
    private var clientId: String {
        Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as? String ?? ""
    }

    private var clientSecret: String {
        Bundle.main.object(forInfoDictionaryKey: "NMFClientSecret") as? String ?? ""
    }

    func searchPlaces(keyword: String, coordinate: CLLocationCoordinate2D, completion: @escaping ([Place]) -> Void) {
        guard var components = URLComponents(string: baseURL) else {
            completion([])
            return
        }

        components.queryItems = [
            URLQueryItem(name: "query", value: keyword),
            URLQueryItem(name: "display", value: "5"),
            URLQueryItem(name: "sort", value: "random")
        ]

        guard let url = components.url else {
            completion([])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(clientId, forHTTPHeaderField: "X-Naver-Client-Id")
        request.setValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                error == nil,
                let data = data,
                let result = try? JSONDecoder().decode(PlaceSearchResponse.self, from: data)
            else {
                completion([])
                return
            }

            let places = result.items.map {
                Place(name: $0.title.htmlStripped,
                      address: $0.roadAddress ?? $0.address ?? "주소 없음")
            }

            completion(places)
        }.resume()
    }
}
