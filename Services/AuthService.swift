//
//  AuthService.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Services/AuthService.swift

import Foundation

// 사용자 정보를 저장하는 구조체
struct User: Codable {
    let id: String
    let email: String
    let firstName: String
    let lastName: String
}

// 인증 서비스 클래스
class AuthService {
    // 싱글톤 인스턴스: 앱 전체에서 하나의 AuthService 인스턴스를 공유
    static let shared = AuthService()
    
    // 현재 로그인된 사용자 정보를 저장하는 변수
    private var currentUser: User?
    
    // 사용자 정보에 접근하는 속성
    var user: User? {
        return currentUser
    }
    
    // 초기화 메서드: 앱 시작 시 저장된 사용자 정보를 로드
    private init() {
        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.currentUser = user
        }
    }
    
    // 로그인 메서드: 이메일과 비밀번호를 받아 로그인 처리
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        // 더미 데이터로 로그인 처리 (실제로는 서버와 통신)
        if email == "test@example.com" && password == "password123" {
            let user = User(id: "1", email: email, firstName: "Test", lastName: "User")
            self.currentUser = user
            // 사용자 정보를 UserDefaults에 저장
            if let userData = try? JSONEncoder().encode(user) {
                UserDefaults.standard.set(userData, forKey: "currentUser")
            }
            completion(.success(user))
        } else {
            // 로그인 실패 시 에러 반환
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid email or password"])
            completion(.failure(error))
        }
    }
    
    // 로그아웃 메서드: 사용자 정보를 초기화하고 저장된 데이터 삭제
    func logout(completion: @escaping () -> Void) {
        self.currentUser = nil
        UserDefaults.standard.removeObject(forKey: "currentUser")
        completion()
    }
}
