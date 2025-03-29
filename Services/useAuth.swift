//
//  useAuth.swift
//  OnTheList
//
//  Created by Byungjin (Chris) Choi on 3/29/25.
//

// File Path: Services/useAuth.swift

import Foundation

// 인증 상태를 관리하는 커스텀 훅 구조체
struct useAuth {
    // 현재 로그인된 사용자 정보를 반환
    var user: User? {
        return AuthService.shared.user
    }
    
    // 로그인 메서드: AuthService의 login 메서드를 호출
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        AuthService.shared.login(email: email, password: password, completion: completion)
    }
    
    // 로그아웃 메서드: AuthService의 logout 메서드를 호출
    func logout(completion: @escaping () -> Void) {
        AuthService.shared.logout(completion: completion)
    }
}
