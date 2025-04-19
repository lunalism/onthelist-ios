//
//  MainTabView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI

/// 메인 탭바를 구성하는 뷰
struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // 검색 탭
            SearchView()
                .tabItem {
                    Label(NSLocalizedString("tab_search", comment: "검색"), systemImage: "magnifyingglass")
                }
                .tag(0)

            // 추천 탭
            RecommendView()
                .tabItem {
                    Label(NSLocalizedString("tab_recommend", comment: "추천"), systemImage: "sparkles")
                }
                .tag(1)

            // 카테고리 탭
            CategoryView()
                .tabItem {
                    Label(NSLocalizedString("tab_category", comment: "카테고리"), systemImage: "square.grid.2x2")
                }
                .tag(2)

            // 컬렉션 탭
            CollectionView()
                .tabItem {
                    Label(NSLocalizedString("tab_collection", comment: "컬렉션"), systemImage: "bookmark")
                }
                .tag(3)

            // 더보기 탭
            MoreView()
                .tabItem {
                    Label(NSLocalizedString("tab_more", comment: "더보기"), systemImage: "ellipsis")
                }
                .tag(4)
        }
    }
}

#Preview {
    MainTabView()
}
