//
//  OnTheListApp.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/28/25.
//

// File Path: OnTheListApp.swift

import SwiftUI

// 앱의 진입점
@main
struct OnTheListApp: App {
    @State private var showSplashScreen: Bool = true // 스플래시 화면 표시 여부
    @State private var splashOpacity: Double = 1.0 // 스플래시 화면 투명도
    @State private var tabViewOpacity: Double = 0.0 // 탭 뷰 투명도
    @State private var isLoggedIn: Bool = false // 로그인 상태 관리
    @State private var selectedTab: Int = 0 // 현재 선택된 탭 인덱스
    @State private var showProfileView: Bool = false // 프로필 화면 표시 여부
    private let auth = useAuth() // useAuth 훅 인스턴스

    // 초기화 메서드: 앱 시작 시 로그인 상태 확인
    init() {
        _isLoggedIn = State(initialValue: auth.user != nil)
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                // 스플래시 화면 표시
                if showSplashScreen {
                    SplashView(
                        onFinish: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                splashOpacity = 0.0
                                tabViewOpacity = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                showSplashScreen = false
                            }
                        },
                        splashOpacity: $splashOpacity
                    )
                    .opacity(splashOpacity)
                } else {
                    // 메인 화면: ZStack으로 탭 뷰 구성
                    ZStack {
                        // 선택된 탭에 따라 뷰 표시
                        switch selectedTab {
                        case 0:
                            ContentView(isLoggedIn: $isLoggedIn)
                        case 2:
                            CollectionView(isLoggedIn: $isLoggedIn)
                        case 3:
                            MoreView()
                        default:
                            EmptyView() // 프로필 탭은 fullScreenCover로 표시
                        }

                        // 커스텀 탭 바
                        VStack {
                            Spacer()
                            CustomTabBar(selectedTab: $selectedTab, showProfileView: $showProfileView)
                        }
                    }
                    .opacity(tabViewOpacity)
                    .environment(\.font, .pretendard(size: 16, weight: .regular))
                    // 프로필 탭은 fullScreenCover로 표시 (위에서 아래로 내려오는 애니메이션)
                    .fullScreenCover(isPresented: $showProfileView) {
                        if auth.user != nil {
                            ProfileView(isLoggedIn: $isLoggedIn)
                        } else {
                            LoginView(isLoggedIn: $isLoggedIn)
                        }
                    }
                }
            }
        }
    }
}

// 커스텀 탭 바 뷰
struct CustomTabBar: View {
    @Binding var selectedTab: Int // 현재 선택된 탭 인덱스
    @Binding var showProfileView: Bool // 프로필 화면 표시 여부

    var body: some View {
        // 탭 바를 가로로 배치
        HStack {
            // 검색 탭 버튼
            TabBarButton(icon: "magnifyingglass", label: "검색", isSelected: selectedTab == 0) {
                selectedTab = 0
                showProfileView = false
            }

            // 컬렉션 탭 버튼
            TabBarButton(icon: "bookmark", label: "컬렉션", isSelected: selectedTab == 2) {
                selectedTab = 2
                showProfileView = false
            }

            // 프로필 탭 버튼
            TabBarButton(icon: "person", label: "프로필", isSelected: selectedTab == 1) {
                selectedTab = 1
                showProfileView = true // 프로필 탭 클릭 시 fullScreenCover 표시
            }

            // 더보기 탭 버튼
            TabBarButton(icon: "ellipsis", label: "더보기", isSelected: selectedTab == 3) {
                selectedTab = 3
                showProfileView = false
            }
        }
        .frame(height: 60)
        .background(Color.white.opacity(0.9))
        .shadow(radius: 2)
        .padding(.bottom, 0)
    }
}

// 탭 바 버튼 뷰
struct TabBarButton: View {
    let icon: String // 버튼 아이콘 이름
    let label: String // 버튼 라벨
    let isSelected: Bool // 선택 여부
    let action: () -> Void // 버튼 클릭 시 동작

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .blue : .gray)

                Text(label)
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(isSelected ? .blue : .gray)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
