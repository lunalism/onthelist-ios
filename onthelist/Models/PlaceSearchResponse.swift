//
//  PlaceSearchResponse.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import Foundation

struct PlaceSearchResponse: Decodable {
    let items: [PlaceSearchItem]
}

struct PlaceSearchItem: Decodable {
    let title: String
    let link: String
    let category: String
    let description: String
    let telephone: String?
    let address: String?
    let roadAddress: String?
}
