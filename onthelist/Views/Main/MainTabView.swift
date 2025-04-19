//
//  MainTabView.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

// Views/Main/MainTabView.swift

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("검색")
                }
            
            RecommendView()
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("추천")
                }
            
            CategoryView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("카테고리")
                }

            CollectionView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("컬렉션")
                }

            MoreView()
                .tabItem {
                    Image(systemName: "ellipsis")
                    Text("더보기")
                }
        }
    }
}
