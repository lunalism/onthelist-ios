//
//  MoreView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Views/MoreView.swift

import SwiftUI

// 더보기 화면 뷰
struct MoreView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // 더보기 타이틀
                Text("더보기")
                    .font(.pretendard(size: 24, weight: .bold))
                    .foregroundColor(.black)

                // 더미 콘텐츠
                Text("설정 및 기타 기능")
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundColor(.gray)

                Spacer() // 하단 여백 추가
            }
            .padding()
            .navigationTitle("더보기")
        }
    }
}

// 프리뷰 제공자
struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
