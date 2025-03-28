//
//  GridientColors.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

import SwiftUI

// 그라데이션 색상 조합 정의
struct GradientColors {
    static let gradients: [[Color]] = [
        [Color.blue, Color.purple], // 파랑 → 보라
        [Color.green, Color.teal], // 초록 → 청록
        [Color.yellow, Color.orange], // 노랑 → 주황
        [Color.pink, Color.purple], // 핑크 → 보라
        [Color.cyan, Color.blue], // 청록 → 파랑
        [Color.indigo, Color.purple], // 남색 → 보라
        [Color.orange, Color.pink] // 주황 → 핑크
    ]

    // 랜덤 그라데이션 선택
    static func randomGradient() -> [Color] {
        gradients.randomElement() ?? gradients[0]
    }
}
