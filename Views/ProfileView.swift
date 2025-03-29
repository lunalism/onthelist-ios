//
//  ProfileView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Views/ProfileView.swift

import SwiftUI

// 프로필 화면 뷰
struct ProfileView: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 관리하는 바인딩 변수
    @State private var isLoading: Bool = false // 로딩 상태
    @State private var showLoginView: Bool = false // 로그인 화면 표시 여부
    private let auth = useAuth() // useAuth 훅 인스턴스

    var body: some View {
        NavigationStack {
            // 로그인 상태에 따라 UI 변경
            if let user = auth.user {
                // 로그인 상태: 사용자 정보와 로그아웃 버튼 표시
                VStack(spacing: 20) {
                    // 사용자 정보 표시
                    Text("환영합니다, \(user.firstName) \(user.lastName)님!")
                        .font(.pretendard(size: 24, weight: .bold))
                        .foregroundColor(.black)

                    Text("이메일: \(user.email)")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundColor(.gray)

                    // 로그아웃 버튼
                    Button(action: {
                        logout() // 로그아웃 함수 호출
                    }) {
                        Text(isLoading ? "로그아웃 중..." : "로그아웃")
                            .font(.pretendard(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    .disabled(isLoading) // 로딩 중일 때는 버튼 비활성화
                    .padding(.horizontal)

                    Spacer() // 하단 여백 추가
                }
                .padding()
                .navigationTitle("프로필")
            } else {
                // 로그아웃 상태: 로그인 화면으로 이동
                VStack {
                    Text("로그인이 필요합니다.")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundColor(.gray)
                        .padding()

                    Button(action: {
                        showLoginView = true // 로그인 화면 표시
                    }) {
                        Text("로그인")
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
                .navigationTitle("프로필")
                .sheet(isPresented: $showLoginView) {
                    // 로그인 화면 표시 (모달로 표시)
                    LoginView(isLoggedIn: $isLoggedIn)
                }
            }
        }
    }

    // 로그아웃 처리 함수
    private func logout() {
        isLoading = true // 로딩 상태 활성화
        auth.logout {
            DispatchQueue.main.async {
                isLoading = false // 로딩 상태 비활성화
                isLoggedIn = false // 로그아웃 상태로 변경
            }
        }
    }
}

// 프리뷰 제공자
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isLoggedIn: .constant(true))
    }
}
