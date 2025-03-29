//
//  EmailLoginView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Views/EmailLoginView.swift

import SwiftUI

// 이메일 로그인 화면 뷰
struct EmailLoginView: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 관리하는 바인딩 변수
    @State private var email: String = "" // 이메일 입력 상태
    @State private var password: String = "" // 비밀번호 입력 상태
    @State private var errorMessage: String? // 에러 메시지 상태
    @State private var isLoading: Bool = false // 로딩 상태
    private let auth = useAuth() // useAuth 훅 인스턴스

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // 상단 여백: 상태 바와 다이나믹 아일랜드 아래에서 시작하도록 패딩 추가
                Spacer()
                    .frame(height: 60)

                // 제목: "로그인" 텍스트 표시
                Text("이메일 주소를 입력해주세요")
                    .font(.pretendard(size: 20, weight: .bold))
                    .foregroundColor(.black)

                // 이메일 입력 필드: 사용자가 이메일을 입력할 수 있는 텍스트 필드
                TextField("이메일", text: $email)
                    .font(.pretendard(size: 14, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.vertical, 8) // 세로 패딩 줄이기
                    .padding(.horizontal, 12) // 가로 패딩 조정
                    .frame(maxWidth: 300) // 가로 길이 조정
                    .frame(height: 40) // 높이 조정
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4) // 모서리 둥글기 조정
                    .autocapitalization(.none) // 대문자 자동 변환 비활성화
                    .keyboardType(.emailAddress) // 이메일 키보드 타입 설정

                /* 비밀번호 입력 필드: 비밀번호를 안전하게 입력할 수 있는 SecureField
                SecureField("비밀번호", text: $password)
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .padding(.vertical, 8) // 세로 패딩 줄이기
                    .padding(.horizontal, 12) // 가로 패딩 조정
                    .frame(maxWidth: 300) // 가로 길이 조정
                    .frame(height: 40) // 높이 조정
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(4) // 모서리 둥글기 조정
                 */

                // 에러 메시지 표시: 로그인 실패 시 에러 메시지 표시
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                // 로그인 버튼: 로그인 동작 실행
                Button(action: {
                    login() // 로그인 함수 호출
                }) {
                    Text(isLoading ? "로그인 중..." : "로그인")
                        .font(.pretendard(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(height: 20)
                        .frame(maxWidth: 280)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(hex: "0F4C81"))
                        .cornerRadius(4)
                }
                .disabled(isLoading) // 로딩 중일 때는 버튼 비활성화
                
                // 약관 동의 문구
                Text("로그인을 진행하시는 경우 OnTheList의 개인정보보호약관과 서비스이용약관에 동의하는 것으로 간주됩니다")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                
                Spacer() // 하단 여백 추가
                
                Button(action: {
                    // 더미 동작: 구글 로그인 (나중에 실제 로직 추가)
                    print("구글 아이디로 로그인")
                }) {
                    HStack {
                        // 구글 아이콘: Assets에서 "google" 이미지 사용
                        Image("google")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)

                        Text("구글 아이디로 로그인")
                            .font(.pretendard(size: 14, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .frame(height: 34)
                    .frame(maxWidth: 300)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                .padding(.bottom, -10)

                // 2행: 애플 아이디로 로그인 버튼
                Button(action: {
                    // 더미 동작: 애플 로그인 (나중에 실제 로직 추가)
                    print("애플 아이디로 로그인")
                }) {
                    HStack {
                        // 애플 아이콘: Assets에서 "apple" 이미지 사용
                        Image("apple")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)

                        Text("애플 아이디로 로그인")
                            .font(.pretendard(size: 14, weight: .regular))
                            .foregroundColor(.black)
                    }
                    .frame(height: 34)
                    .frame(maxWidth: 300)
                    .padding(.horizontal, 10)
                    .background(Color.white)
                    .cornerRadius(4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    )
                }
                
                // 하단 문구: 약관 동의 문구
                Text("계정이 없으신가요?")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                Text("회원가입")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(.gray)

                
                
            }
            .padding()
            .background(Color.white)
            // 기본 "Back" 버튼 숨기기
            .navigationBarBackButtonHidden(true)
            // 왼쪽 상단에 커스텀 "Back" 버튼 추가
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // NavigationStack에서 이전 화면으로 돌아가기
                        // NavigationLink로 이동했으므로 자동으로 pop됨
                    }) {
                        Image(systemName: "chevron.left") // "chevron.left" 아이콘 사용
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24) // 버튼 크기 조정
                            .background(Color.gray.opacity(0.8)) // 회색 배경
                            .clipShape(Circle()) // 원형 모양
                            .shadow(radius: 2) // 그림자 추가
                    }
                }
            }
        }
    }

    // 로그인 처리 함수
    private func login() {
        isLoading = true // 로딩 상태 활성화
        errorMessage = nil // 이전 에러 메시지 초기화

        // useAuth 훅을 사용해서 로그인 요청
        auth.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                isLoading = false // 로딩 상태 비활성화
                switch result {
                case .success:
                    isLoggedIn = true // 로그인 성공 시 상태 업데이트
                    // NavigationStack에서 이전 화면으로 돌아가기
                    // NavigationLink로 이동했으므로 자동으로 pop됨
                case .failure(let error):
                    errorMessage = error.localizedDescription // 에러 메시지 표시
                }
            }
        }
    }
}

// 프리뷰 제공자
struct EmailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView(isLoggedIn: .constant(false))
    }
}
