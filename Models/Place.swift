//
//  Place.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// Models/Place.swift
public struct Place: Codable {
    let google_place_id: String
    let title: String
    let address: String
    // 추가 필드 필요 시 정의
}
