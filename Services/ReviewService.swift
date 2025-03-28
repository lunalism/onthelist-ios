//
//  ReviewService.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

import Foundation

class ReviewService {
    static func fetchReviews(limit: Int = 8) async throws -> [Review] {
        let response = try await supabase
            .from("reviews")
            .select("*, user:users(*)")
            .order("created_at", ascending: false)
            .limit(limit)
            .execute()

        // 디버깅: response.data 출력
        if let dataString = String(data: response.data, encoding: .utf8) {
            print("Response Data: \(dataString)")
        } else {
            print("Response Data is empty or invalid")
        }

        return try JSONDecoder().decode([Review].self, from: response.data)
    }

    static func fetchReviews(forPlaceId placeId: String) async throws -> [Review] {
        let response = try await supabase
            .from("reviews")
            .select("*, user:users(*)")
            .eq("place_id", value: placeId)
            .order("created_at", ascending: false)
            .execute()

        // 디버깅: response.data 출력
        if let dataString = String(data: response.data, encoding: .utf8) {
            print("Response Data: \(dataString)")
        } else {
            print("Response Data is empty or invalid")
        }

        return try JSONDecoder().decode([Review].self, from: response.data)
    }
}
