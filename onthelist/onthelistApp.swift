//
//  onthelistApp.swift
//  onthelist
//
//  Created by Byungjin (Chris) Choi on 4/19/25.
//

import SwiftUI
import NMapsMap

@main
struct onthelistApp: App {
    init() {
            // Info.plist에서 클라이언트 ID 읽기
            if let clientId = Bundle.main.object(forInfoDictionaryKey: "NMFNcpKeyId") as? String {
                NMFAuthManager.shared().clientId = clientId
                print("✅ 네이버 지도 Client ID 설정 완료: \(clientId)")
            } else {
                print("❌ NMFNcpKeyId를 Info.plist에서 찾을 수 없습니다.")
            }
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
