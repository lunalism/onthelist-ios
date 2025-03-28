//
//  SplashView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//
//
//  SplashView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//
import SwiftUI

struct SplashView: View {
    @State private var showLogo = false
    @State private var showSubtitle = false
    @State private var showMainScreen = false
    @State private var gradientColors: [Color] = GradientColors.randomGradient()

    var body: some View {
        ZStack {
            if showMainScreen {
                ContentView() // 메인 화면으로 전환
            } else {
                // 그라데이션 배경
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack {
                    // 로고 이미지
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200) // 로고 크기 조정 (필요에 따라 변경)
                        .opacity(showLogo ? 1 : 0)

                    // 서브타이틀
                    if showSubtitle {
                        Text("세상에 없던 리뷰모음기")
                            .font(.system(size: 20, weight: .medium, design: .default))
                            .foregroundColor(.white.opacity(0.8))
                            .padding(.top, -50) // 로고와의 간격 조정
                            .opacity(showSubtitle ? 1 : 0)
                            .animation(.easeInOut(duration: 0.5), value: showSubtitle)
                    }
                }
            }
        }
        .onAppear {
            // 거울 닦이는 효과 (wipe animation)
            withAnimation(.easeInOut(duration: 1.0)) {
                showLogo = true
            }

            // 로고가 나타난 후 1초 뒤 서브타이틀 표시
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    showSubtitle = true
                }

                // 서브타이틀이 나타난 후 2초 뒤 메인 화면으로 전환
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    showMainScreen = true
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
