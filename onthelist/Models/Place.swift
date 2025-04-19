//
//  Place.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 2025/04/19.
//

import Foundation

struct Place: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let address: String
}
