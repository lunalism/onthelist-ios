//
//  OnTheListApp.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

import SwiftUI

@main
struct OnTheListApp: App {
    @State private var showSplashScreen = true
    @State private var splashOpacity: Double = 1.0
    @State private var tabViewOpacity: Double = 0.0

    var body: some Scene {
        WindowGroup {
            ZStack {
                // TabView (메인 화면)
                TabView {

                    ContentView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("검색")
                        }
                        .tag(0)

                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("프로필")
                        }
                        .tag(1)

                    CollectionView()
                        .tabItem {
                            Image(systemName: "bookmark")
                            Text("컬렉션")
                        }
                        .tag(2)

                    MoreView()
                        .tabItem {
                            Image(systemName: "ellipsis")
                            Text("더보기")
                        }
                        .tag(3)
                }
                .accentColor(.blue)
                .tabViewStyle(.automatic)
                .opacity(tabViewOpacity) // TabView의 페이드 인
                .environment(\.font, .pretendard(size: 14, weight: .regular)) // 앱 전체 기본 폰트 설정
                .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.configureWithOpaqueBackground()
                    appearance.backgroundColor = UIColor.white.withAlphaComponent(0.9)
                    appearance.shadowColor = UIColor.black.withAlphaComponent(0.1)
                    appearance.shadowImage = UIImage()
                    UITabBar.appearance().standardAppearance = appearance
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }

                // SplashView (스플래시 화면)
                if showSplashScreen {
                    SplashView(
                        onFinish: {
                            // 스플래시 화면 페이드 아웃, TabView 페이드 인
                            withAnimation(.easeInOut(duration: 0.5)) {
                                splashOpacity = 0.0
                                tabViewOpacity = 1.0
                            }
                            // 스플래시 화면 제거
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showSplashScreen = false
                            }
                        },
                        splashOpacity: $splashOpacity
                    )
                    .opacity(splashOpacity) // 스플래시 화면의 페이드 아웃
                }
            }
        }
    }
}
