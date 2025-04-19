//
//  SplashView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI

struct SplashView: View {
    @State private var showSubtitle = false
    @State private var logoOffset: CGFloat = 0
    @State private var navigate = false

    /// 랜덤 그라데이션 선택
    private let gradient = splashGradients.randomElement() ?? [.black, .gray]

    var body: some View {
        ZStack {
            // MARK: - 그라데이션 배경
            LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()

            VStack {
                // MARK: - 로고
                Image("logo")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .offset(y: logoOffset)
                    .onAppear {
                        // 1초 후 위로 살짝 이동
                        withAnimation(.easeOut(duration: 1.0)) {
                            logoOffset = -20
                        }

                        // 로고 이동 이후 서브타이틀 등장
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                            withAnimation(.easeIn) {
                                showSubtitle = true
                            }
                        }

                        // 2.5초 후 다음 화면으로 전환
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            navigate = true
                        }
                    }

                // MARK: - 서브타이틀
                if showSubtitle {
                    Text("splash.subtitle")
                        .font(.system(size: 20, weight: .light))
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .padding(.top, 10)
                }
            }
        }
        // MARK: - 자동 네비게이션 트리거
        .fullScreenCover(isPresented: $navigate) {
            MainTabView() // 다음 화면으로 이동
        }
    }
}

#Preview {
    SplashView()
}
