//
//  LanguageSelectView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI

struct LanguageSelectView: View {
    @AppStorage("appLanguage") private var language: String = "ko"
    @State private var navigate = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 32) {
                // MARK: - 타이틀
                Text("언어를 선택해주세요")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                // MARK: - 한국어 버튼
                Button(action: {
                    selectLanguage("ko")
                }) {
                    Text("🇰🇷 한국어")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                }

                // MARK: - 영어 버튼
                Button(action: {
                    selectLanguage("en")
                }) {
                    Text("🇺🇸 English")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal, 32)
            .fullScreenCover(isPresented: $navigate) {
                SearchView() // 메인 화면으로 이동
            }
        }
    }

    // MARK: - 언어 선택 처리
    private func selectLanguage(_ lang: String) {
        language = lang
        // 잠깐 delay 후 화면 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            navigate = true
        }
    }
}

#Preview {
    LanguageSelectView()
}
