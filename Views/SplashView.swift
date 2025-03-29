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
    @State private var scaleLogo: CGFloat = 1.0
    @State private var rotateLogo: Angle = .degrees(0)
    @State private var subtitleOpacity: Double = 1.0
    @State private var gradientColors: [Color] = GradientColors.randomGradient()
    var onFinish: () -> Void
    @Binding var splashOpacity: Double

    var body: some View {
        ZStack {
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
                    .frame(width: 100)
                    .scaleEffect(scaleLogo) // 로고 크기 조정
                    .rotationEffect(rotateLogo) // 로고 회전
                    .blur(radius: scaleLogo > 1.0 ? (scaleLogo - 1.0) * 0.5 : 0) // 확대될수록 흐림 효과
                    .opacity(showLogo ? 1 : 0)

                // 서브타이틀
                if showSubtitle {
                    Text("세상에 없던 리뷰모음기")
                        .font(.system(size: 20, weight: .medium, design: .default))
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 6)
                        .opacity(subtitleOpacity) // 서브타이틀 페이드 아웃
                        .animation(.easeInOut(duration: 0.5), value: subtitleOpacity)
                }
            }
        }
        .onAppear {
            print("SplashView appeared")
            // 0~1초: 로고 페이드 인
            withAnimation(.easeInOut(duration: 1.0)) {
                showLogo = true
            }

            // 1~2초: 서브타이틀 페이드 인
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                print("Showing subtitle")
                withAnimation {
                    showSubtitle = true
                }
            }

            // 2~2.7초: 서브타이틀 페이드 아웃, 로고 커지기 및 회전
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                print("Scaling logo and fading out subtitle")
                withAnimation(.easeInOut(duration: 0.7)) {
                    scaleLogo = 20.0 // 로고 크기 30배 (화면을 완전히 넘치게)
                    rotateLogo = .degrees(30) // 로고 30도 회전
                    subtitleOpacity = 0.0 // 서브타이틀 페이드 아웃
                }
            }

            // 2.7~3.5초: 스플래시 화면 페이드 아웃, TabView 페이드 인
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                print("Calling onFinish")
                onFinish()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView(onFinish: {}, splashOpacity: .constant(1.0))
    }
}
