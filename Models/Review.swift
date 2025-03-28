//
//  Review.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// Models/Review.swift
struct Review: Identifiable, Codable {
    let id: String
    let user_id: String
    let created_at: String
    let rating: Double
    let image_urls: [String]?
    let place_id: String
    let review: String
    let user: User
    let likes_count: Int
    let helpful: Int
    let insightful: Int
    let disappointing: Int
    // let userReactions: [String: Bool] // 제거

    struct User: Codable {
        let first_name: String
        let last_name: String
        let profile_image_url: String?
    }

    // 추가 필드 무시
    enum CodingKeys: String, CodingKey {
        case id
        case user_id
        case created_at
        case rating
        case image_urls
        case place_id
        case review
        case user
        case likes_count
        case helpful
        case insightful
        case disappointing
        // visited_at, is_html, updated_at은 무시
    }
}
