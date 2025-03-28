//
//  ContentView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

import SwiftUI
import Supabase

struct ContentView: View {
    @State private var reviews: [Review] = []
    @State private var isLoading = false
    @State private var error: String?
    @State private var currentImageIndex = 0 // 현재 이미지 인덱스
    @State private var timer: Timer? // 이미지 전환 타이머

    // 메인 이미지 이름 배열
    private let mainImages = ["main01", "main02", "main03", "main04", "main05", "main06", "main07", "main08"]

    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack {
                // 메인 이미지 (자동 교체)
                Image(mainImages[currentImageIndex])
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center) // alignment 추가
                    .clipped()
                    .onAppear {
                        // 타이머 설정: 3초마다 이미지 전환
                        timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                            withAnimation {
                                currentImageIndex = (currentImageIndex + 1) % mainImages.count
                            }
                        }
                    }
                    .onDisappear {
                        // 화면이 사라질 때 타이머 해제
                        timer?.invalidate()
                        timer = nil
                    }

                // 리뷰 목록 (2x4 레이아웃)
                if isLoading {
                    ProgressView()
                        .padding()
                } else if let error = error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10)
                        ], spacing: 10) {
                            ForEach(reviews) { review in
                                NavigationLink(destination: PlaceDetailView(review: review)) {
                                    ReviewCard(review: review)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }

            // 로고 (왼쪽 위)
            Text("OnTheList")
                .font(.system(size: 28, weight: .bold, design: .default))
                .foregroundColor(.white)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(Color.black.opacity(0.5))
                .cornerRadius(8)
                .padding(.top, 10)
                .padding(.leading, 16)
                .shadow(radius: 2)
        }
        .onAppear {
            fetchReviews()
        }
    }

    func fetchReviews() {
        isLoading = true
        Task {
            do {
                let reviews = try await ReviewService.fetchReviews()
                self.reviews = reviews
                self.isLoading = false
            } catch {
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}

struct ReviewCard: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            // 사용자 정보
            HStack {
                if let profileImageUrl = review.user.profile_image_url {
                    AsyncImage(url: URL(string: profileImageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 30, height: 30)
                }
                VStack(alignment: .leading) {
                    Text("\(review.user.last_name)\(review.user.first_name)")
                        .font(.caption)
                        .lineLimit(1)
                    Text(review.created_at)
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }

            // 평점
            HStack {
                ForEach(0..<5) { i in // i.Concurrent → i
                    Star(size: 12, fill: i < Int(review.rating) ? Color.orange : Color.gray)
                }
                Text(review.rating.description)
                    .font(.caption2)
            }

            // 리뷰 내용
            Text(review.review.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil))
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)

            // 리뷰 이미지
            if let imageUrls = review.image_urls, !imageUrls.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(imageUrls, id: \.self) { url in
                            AsyncImage(url: URL(string: url)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray.opacity(0.3)
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                        }
                    }
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct Star: View {
    let size: CGFloat
    let fill: Color

    var body: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: size, height: size)
            .foregroundColor(fill)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
