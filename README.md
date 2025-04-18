# 🗺️ OnTheList - 리뷰 기반 여행 가이드 앱 (iOS)

> 세상에 없던 리뷰 여행기 🌏  
> 신뢰할 수 있는 리뷰와 지도 기반 탐색으로, 외국인도 쉽게 사용할 수 있는 여행 앱을 목표로 개발 중입니다.

---

## 📌 기술 스택

- **iOS 앱 개발**: SwiftUI, Swift 5.0
- **지도 SDK**: [Naver Maps iOS SDK](https://navermaps.github.io/ios-map-sdk/guide-ko/)
- **의존성 관리**: Swift Package Manager (SPM)
- **기타 사용 라이브러리**: 없음 (경량화 중심 설계)

---

## 📦 설치 및 실행

### 1. 클론 후 Xcode 열기

```bash
git clone https://github.com/your-username/onthelist.git
cd onthelist
open onthelist.xcodeproj



## ✅ 현재 구현 완료

- [x] **SwiftUI 프로젝트 구성**
  - 최신 Xcode 기반 SwiftUI 앱 초기화
  - SPM으로 의존성 관리 설정 완료

- [x] **Naver Maps iOS SDK 연동 (SPM)**
  - `NMapsMap` 및 `NMapsGeometry` 패키지 추가
  - Info.plist에 `NMFNcpKeyId` 등록하여 Client ID 적용

- [x] **지도 초기화 성공**
  - 실제 지도 타일 표시 확인
  - SwiftUI에서 `UIViewRepresentable`로 MapView 불러오기

- [x] **파일 구조 분리 시작**
  - `Assets`, `Info.plist`, `ContentView.swift` 구조 확인
  - 향후 다국어, 검색기능, Supabase 연동 계획 수립
