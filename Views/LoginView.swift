//
//  LoginView.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Views/LoginView.swift

import SwiftUI

// 로그인 화면 뷰
struct LoginView: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 관리하는 바인딩 변수
    @Environment(\.dismiss) var dismiss // 화면 닫기 동작을 위한 환경 변수
    @State private var email: String = "" // 이메일 입력 상태
    @State private var password: String = "" // 비밀번호 입력 상태
    @State private var errorMessage: String? // 에러 메시지 상태
    @State private var isLoading: Bool = false // 로딩 상태
    @State private var showEmailLoginView: Bool = false // 이메일 로그인 화면 표시 여부
    private let auth = useAuth() // useAuth 훅 인스턴스

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // 상단 여백: 상태 바와 다이나믹 아일랜드 아래에서 시작하도록 패딩 추가
                Spacer()
                    .frame(height: 0)

                // 상단: Cancel 버튼과 제목
                HStack {
                    Spacer() // 왼쪽 여백
                    // "Cancel" 버튼: 원형 버튼으로 변경
                    Button(action: {
                        dismiss() // 화면 닫기 (아래에서 위로 올라가는 애니메이션)
                    }) {
                        Image(systemName: "xmark") // "xmark" 아이콘 사용
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 30, height: 30) // 버튼 크기 조정
                            .background(Color.gray.opacity(0.8)) // 회색 배경
                            .clipShape(Circle()) // 원형 모양
                            .shadow(radius: 2) // 그림자 추가
                    }
                    .padding(.trailing, 15)
                }

                // 상단 문구: "로그인 또는 회원가입을 해주세요"
                Text("로그인 또는 회원가입을 해주세요")
                    .font(.pretendard(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 20)

                // 이미지: Assets에서 "login" 이미지 표시
                Image("login")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .padding(.vertical, 20)

                // 버튼 목록 (3행 1열)
                VStack(spacing: 10) { // 버튼 간 간격 줄이기
                    // 1행: 구글 아이디로 로그인 버튼
                    Button(action: {
                        // 더미 동작: 구글 로그인 (나중에 실제 로직 추가)
                        print("구글 아이디로 로그인")
                    }) {
                        HStack {
                            // 구글 아이콘: Assets에서 "google" 이미지 사용
                            Image("google")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20) // 아이콘 크기 조정

                            Text("구글 아이디로 로그인")
                                .font(.pretendard(size: 14, weight: .regular)) // 텍스트 크기 조정
                                .foregroundColor(.black)
                        }
                        .frame(height: 40) // 버튼 높이 줄이기
                        .frame(maxWidth: 300) // 버튼 가로 크기 줄이기
                        .padding(.horizontal, 10) // 내부 여백 조정
                        .background(Color.white) // 흰색 배경
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }

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
                                .frame(width: 20, height: 20) // 아이콘 크기 조정

                            Text("애플 아이디로 로그인")
                                .font(.pretendard(size: 14, weight: .regular)) // 텍스트 크기 조정
                                .foregroundColor(.black) // 흰색 텍스트
                        }
                        .frame(height: 40) // 버튼 높이 줄이기
                        .frame(maxWidth: 300) // 버튼 가로 크기 줄이기
                        .padding(.horizontal, 10) // 내부 여백 조정
                        .background(Color.white) // 검은색 배경
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    }

                    // 3행: 로그인 및 회원가입 버튼 (2열)
                    HStack(spacing: 10) {
                        // 로그인 버튼
                        Button(action: {
                            showEmailLoginView = true // 이메일 로그인 화면 표시
                        }) {
                            Text("로그인")
                                .font(.pretendard(size: 14, weight: .bold)) // 텍스트 크기 조정
                                .foregroundColor(.white)
                                .frame(height: 40) // 버튼 높이 줄이기
                                .frame(maxWidth: 135) // 버튼 가로 크기 줄이기
                                .padding(.horizontal, 10) // 내부 여백 조정
                                .background(Color.blue)
                                .cornerRadius(8)
                        }

                        // 회원가입 버튼
                        Button(action: {
                            // 더미 동작: 회원가입 화면 (나중에 구현)
                            print("회원가입 화면으로 이동")
                        }) {
                            Text("회원가입")
                                .font(.pretendard(size: 14, weight: .bold)) // 텍스트 크기 조정
                                .foregroundColor(.white)
                                .frame(height: 40) // 버튼 높이 줄이기
                                .frame(maxWidth: 135) // 버튼 가로 크기 줄이기
                                .padding(.horizontal, 10) // 내부 여백 조정
                                .background(Color.gray)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)

                Spacer() // 하단 여백 추가

                // 하단 문구: 약관 동의 문구
                Text("로그인 또는 회원가입을 진행하시는 경우\nOnTheList의 개인정보보호약관과\n서비스이용약관에 동의하는 것으로 간주됩니다")
                    .font(.pretendard(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            .background(Color.white)
        }
    }
}

// 이메일 로그인 화면 뷰
struct EmailLoginView: View {
    @Binding var isLoggedIn: Bool // 로그인 상태를 관리하는 바인딩 변수
    @Environment(\.dismiss) var dismiss // 화면 닫기 동작을 위한 환경 변수
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

                // 상단: Cancel 버튼
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss() // 화면 닫기
                    }) {
                        Text("Cancel")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 15)
                }

                // 제목
                Text("로그인")
                    .font(.pretendard(size: 24, weight: .bold))
                    .foregroundColor(.black)

                // 이메일 입력 필드
                TextField("이메일", text: $email)
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)

                // 비밀번호 입력 필드
                SecureField("비밀번호", text: $password)
                    .font(.pretendard(size: 16, weight: .regular))
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                // 에러 메시지 표시
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }

                // 로그인 버튼
                Button(action: {
                    login() // 로그인 함수 호출
                }) {
                    Text(isLoading ? "로그인 중..." : "로그인")
                        .font(.pretendard(size: 14, weight: .bold)) // 텍스트 크기 조정
                        .foregroundColor(.white)
                        .frame(height: 40) // 버튼 높이 줄이기
                        .frame(maxWidth: 300) // 버튼 가로 크기 줄이기
                        .padding(.horizontal, 10) // 내부 여백 조정
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(isLoading)
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .background(Color.white)
        }
    }

    // 로그인 처리 함수
    private func login() {
        isLoading = true
        errorMessage = nil

        auth.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success:
                    isLoggedIn = true // 로그인 성공 시 상태 업데이트
                    dismiss() // 로그인 성공 시 화면 닫기
                case .failure(let error):
                    errorMessage = error.localizedDescription
                }
            }
        }
    }
}

// 프리뷰 제공자
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}
