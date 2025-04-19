//
//  MainTabView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI

// 탭 구분을 위한 enum
enum Tab {
    case search, recommend, category, collection, more
}

struct MainTabView: View {
    @State private var selectedTab: Tab = .search

    var body: some View {
        TabView(selection: $selectedTab) {
            // 1. 검색 탭
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
                .tag(Tab.search)

            // 2. 추천 탭
            RecommendView()
                .tabItem {
                    Image(systemName: "sparkles")
                    Text("추천")
                }
                .tag(Tab.recommend)

            // 3. 카테고리 탭
            CategoryView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("카테고리")
                }
                .tag(Tab.category)

            // 4. 컬렉션 탭
            CollectionView()
                .tabItem {
                    Image(systemName: "bookmark")
                    Text("컬렉션")
                }
                .tag(Tab.collection)

            // 5. 더보기 탭
            MoreView()
                .tabItem {
                    Image(systemName: "line.3.horizontal")
                    Text("더보기")
                }
                .tag(Tab.more)
        }
        .accentColor(.blue) // 선택된 탭 아이콘 색상
    }
}

#Preview {
    MainTabView()
}
