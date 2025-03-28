//
//  PlaceService.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// Services/PlaceService.swift
import Foundation

class PlaceService {
    static func fetchPlace(byGooglePlaceId googlePlaceId: String) async throws -> Place {
        let response = try await supabase
            .from("places")
            .select("*")
            .eq("google_place_id", value: googlePlaceId)
            .single()
            .execute()

        return try JSONDecoder().decode(Place.self, from: response.data)
    }
}
