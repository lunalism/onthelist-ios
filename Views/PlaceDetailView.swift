//
//  PlaceDetailView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// Views/PlaceDetailView.swift
import SwiftUI
import WebKit

struct PlaceDetailView: View {
    let review: Review
    @State private var place: Place?
    @State private var reviews: [Review] = []
    @State private var isLoading = false
    @State private var error: String?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                // 사진 슬라이더 (PhotoSlider 기반)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(0..<5) { _ in
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 300, height: 200)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 200)

                // 버튼 (리뷰 작성, 사진 추가 등)
                HStack(spacing: 10) {
                    Button(action: {
                        // 리뷰 작성
                    }) {
                        HStack {
                            Image(systemName: "star.fill")
                            Text("리뷰 작성")
                        }
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    Button(action: {
                        // 사진 추가
                    }) {
                        HStack {
                            Image(systemName: "camera")
                            Text("사진 추가")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundColor(.gray)
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                // 위치 및 영업 시간 (LocationAndHours 기반)
                VStack(alignment: .leading, spacing: 5) {
                    Text("위치 및 영업 시간")
                        .font(.title2)
                        .bold()
                    Text("주소: \(place?.address ?? "미구현")")
                        .foregroundColor(.gray)
                    Text("영업 시간: (미구현)")
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)

                // 리뷰 섹션 (ReviewSection 기반)
                ReviewSectionView(reviews: reviews)
            }
            .padding(.vertical)
        }
        .navigationTitle(place?.title ?? "장소 상세")
        .onAppear {
            fetchPlaceDetails()
        }
    }

    func fetchPlaceDetails() {
        isLoading = true
        Task {
            do {
                // 장소 정보 페칭
                let place = try await PlaceService.fetchPlace(byGooglePlaceId: review.place_id)
                self.place = place

                // 리뷰 페칭
                let reviews = try await ReviewService.fetchReviews(forPlaceId: review.place_id)
                self.reviews = reviews
                self.isLoading = false
            } catch {
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(review: Review(
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
        ))
    }
}
