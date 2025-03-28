//
//  ReviewItemView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// Views/ReviewItemView.swift
import SwiftUI
import WebKit

struct ReviewItemView: View {
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
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 40, height: 40)
                }
                VStack(alignment: .leading) {
                    Text("\(review.user.first_name) \(review.user.last_name)")
                        .font(.headline)
                    Text(review.created_at)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            // 평점
            HStack {
                ForEach(0..<5) { i in
                    Star(size: 16, fill: i < Int(review.rating) ? Color.orange : Color.gray)
                }
                Text(review.rating.description)
                    .font(.caption)
            }

            // 리뷰 내용 (HTML 렌더링)
            WebView(html: review.review)
                .frame(height: 100) // 높이는 내용에 따라 조정 필요

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
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                        }
                    }
                }
            }

            // 반응 버튼
            HStack(spacing: 10) {
                Button(action: {
                    // handleReaction(review.id, "likes_count")
                }) {
                    Text("좋아요 (\(review.likes_count))")
                        .foregroundColor(.gray) // userReactions 제거
                }
                Button(action: {
                    // handleReaction(review.id, "helpful")
                }) {
                    Text("유용해요 (\(review.helpful))")
                        .foregroundColor(.gray) // userReactions 제거
                }
                Button(action: {
                    // handleReaction(review.id, "insightful")
                }) {
                    Text("통찰력 있어요 (\(review.insightful))")
                        .foregroundColor(.gray) // userReactions 제거
                }
                Button(action: {
                    // handleReaction(review.id, "disappointing")
                }) {
                    Text("실망스러워요 (\(review.disappointing))")
                        .foregroundColor(.gray) // userReactions 제거
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct WebView: UIViewRepresentable {
    let html: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.isOpaque = false
        webView.backgroundColor = .clear
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let htmlString = """
        <html>
        <head>
            <style>
                body { font-family: -apple-system; font-size: 16px; color: #4B5563; }
                p { margin: 0; }
            </style>
        </head>
        <body>
            \(html)
        </body>
        </html>
        """
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}

struct ReviewItemView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewItemView(review: Review(
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
