//
//  ContentView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView: View {
    @State private var searchText = ""
    @State private var useGradientBackground = true
    @FocusState private var isTextFieldFocused: Bool

    private let mainImages = ["main01", "main02", "main03", "main04", "main05", "main06", "main07", "main08"]
    private let gradientColors: [Color] = GradientColors.randomGradient()

    var body: some View {
        NavigationStack {
            ZStack {
                // 배경: 초기에는 그라데이션, 이후에는 흰색
                if useGradientBackground {
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()
                } else {
                    Color.white
                        .ignoresSafeArea()
                }

                ScrollView {
                    VStack(spacing: 0) {
                        // 검색 입력창
                        SearchInputView(searchText: $searchText, isTextFieldFocused: _isTextFieldFocused)

                        // 구분선
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.vertical, 10)

                        // 메인 이미지 카드
                        MainImageCard()

                        // 이미지 목록
                        ImageListView(mainImages: mainImages)

                        Spacer() // 탭 뷰와의 간격 유지
                    }
                }
                .onAppear {
                    print("ContentView appeared")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        print("Changing ContentView background to white")
                        withAnimation(.easeInOut(duration: 0.5)) {
                            useGradientBackground = false
                        }
                    }
                }
            }
        }
    }
}

struct SearchInputView: View {
    @Binding var searchText: String
    @FocusState var isTextFieldFocused: Bool

    var body: some View {
        HStack {
            TextField("어느 세계의 리뷰를 탐험하실건가요?", text: $searchText)
                .font(.pretendard(size: 14, weight: .regular))
                .foregroundColor(.black)
                .padding(.vertical, 8)
                .padding(.leading, 15)
                .focused($isTextFieldFocused)

            ZStack {
                Circle()
                    .fill(Color(hex: "0F4C81"))
                    .frame(width: 24, height: 24)

                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .medium))
            }
            .padding(.trailing, 8)

            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    isTextFieldFocused = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                        .padding(.trailing, 8)
                }
            }
        }
        .frame(height: 40)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
        .shadow(radius: 2, x: 0, y: 0)
        .padding(.horizontal)
        .padding(.top, 0)
    }
}

struct MainImageCard: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image("main01")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .shadow(radius: 5)

            VStack(alignment: .leading, spacing: 4) {
                Text("On The List에서 추천하는 최고의 한식당")
                    .font(.pretendard(size: 16, weight: .heavy))
                    .foregroundColor(.white)

                HStack(spacing: 5) {
                    Text("목록 보기")
                        .font(.pretendard(size: 14, weight: .medium))
                        .foregroundColor(.white)

                    Image(systemName: "chevron.right")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color.black.opacity(0.5)) // 검은색 반투명 배경 추가
            .cornerRadius(8) // 모서리 둥글게
            .padding(.leading, 15)
            .padding(.bottom, 15)
        }
        .padding(.horizontal)
    }
}

struct ImageListView: View {
    let mainImages: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(mainImages, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .shadow(radius: 2)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
