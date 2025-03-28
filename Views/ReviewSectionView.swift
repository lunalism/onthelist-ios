//
//  ReviewSectionView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// Views/ReviewSectionView.swift
import SwiftUI

struct ReviewSectionView: View {
    let reviews: [Review]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("리뷰")
                .font(.title2)
                .bold()
            ForEach(reviews) { review in
                ReviewItemView(review: review)
            }
        }
        .padding(.horizontal)
    }
}

struct ReviewSectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewSectionView(reviews: [
            Review(
                id: "1",
                user_id: "user1",
                created_at: "2023-10-01",
                rating: 4.5,
                image_urls: ["https://via.placeholder.com/80"],
                place_id: "place1",
                review: "<p>좋아요!</p>",
                user: Review.User(first_name: "John", last_name: "Doe", profile_image_url: nil),
                likes_count: 10,
                helpful: 5,
                insightful: 3,
                disappointing: 1
            )
        ])
    }
}
