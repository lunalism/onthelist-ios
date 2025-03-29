//
//  CollectionView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Views/CollectionView.swift

import SwiftUI

// 컬렉션 화면 뷰
struct CollectionView: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 관리하는 바인딩 변수
    @State private var showLoginView: Bool = false // 로그인 화면 표시 여부
    private let auth = useAuth() // useAuth 훅 인스턴스

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // 컬렉션 타이틀
                Text("나의 컬렉션")
                    .font(.pretendard(size: 24, weight: .bold))
                    .foregroundColor(.black)

                // 더미 데이터: 컬렉션에 장소 추가 버튼
                Button(action: {
                    // 장소 저장 시 로그인 상태 확인
                    if auth.user == nil {
                        showLoginView = true // 로그인이 필요하면 로그인 화면 표시
                    } else {
                        // 로그인 상태: 장소 저장 로직 (여기서는 더미 동작)
                        print("장소가 컬렉션에 저장되었습니다.")
                    }
                }) {
                    Text("장소 저장")
                        .font(.pretendard(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer() // 하단 여백 추가
            }
            .padding()
            .navigationTitle("컬렉션")
            .sheet(isPresented: $showLoginView) {
                // 로그인 화면 표시 (모달로 표시)
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

// 프리뷰 제공자
struct CollectionView_Previews: PreviewProvider {
    static var previews: some View {
        CollectionView(isLoggedIn: .constant(false))
    }
}
