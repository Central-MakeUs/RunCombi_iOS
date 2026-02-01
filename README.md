![Frame 1739333118](https://github.com/user-attachments/assets/1602d110-f215-4a50-80ca-6939784006e9)

# 런콤비 (RunCombi) iOS

반려견과 함께하는 운동 기록 앱

## 1. 프로젝트 개요

런콤비는 반려견과 함께 산책/운동하는 시간을 기록하고 관리하는 iOS/watchOS 앱입니다.

**지원 플랫폼:**
- iOS 17.0+
- watchOS 9.0+

---

## 주요 기능

### 인증 (FeatureLogin)
| 기능 | 설명 |
|------|------|
| 소셜 로그인 | 카카오, Apple 로그인 지원 |
| 토큰 관리 | 액세스 토큰 자동 갱신 (리프레시 토큰) |
| 자동 로그인 | KeychainAccess 기반 토큰 저장 |

### 회원가입 (FeatureSignUp)
| 기능 | 설명 |
|------|------|
| 서비스 약관 동의 | 필수/선택 약관 동의 처리 |
| 사용자 정보 입력 | 닉네임, 성별, 신체 정보 (키/몸무게) |
| 반려견 정보 입력 | 이름, 견종, 체형 정보, 산책 스타일 |
| 프로필 이미지 | 카메라/갤러리에서 이미지 선택, 크롭 기능 |

### 운동 기록 (FeatureExercise)
| 기능 | 설명 |
|------|------|
| GPS 경로 추적 | Google Maps 기반 실시간 위치 추적 |
| 운동 시간 측정 | 타이머 (시작/일시정지/종료) |
| 운동 거리 측정 | GPS 좌표 기반 이동 거리 계산 (km) |
| 칼로리 계산 | 사용자/반려견 각각 소모 칼로리 표시 |
| 운동 완료 화면 | 경로 지도 스냅샷, Lottie 축하 애니메이션 |
| 운동 사진 촬영 | 운동 완료 후 사진 촬영 및 저장 |
| 카운트다운 | 운동 시작 전 3초 카운트다운 |
| 백그라운드 추적 | 앱이 백그라운드일 때도 위치 추적 |

### 캘린더 (FeatureCalendar)
| 기능 | 설명 |
|------|------|
| 월별 캘린더 | 운동 기록이 있는 날짜 표시 |
| 월간 통계 | 평균 운동 시간, 평균 운동 거리, 자주한 운동 스타일 |
| 일별 기록 조회 | 특정 날짜의 운동 기록 목록 |

### 운동 기록 상세 (FeatureRecord)
| 기능 | 설명 |
|------|------|
| 기록 상세 조회 | 운동 시간, 거리, 칼로리, 경로 지도 |
| 기록 수정 | 메모 추가, 사진 변경 |
| 기록 삭제 | 삭제 확인 바텀시트 |
| 운동 평가 | 운동 만족도 평가 |
| 사진 추가/변경 | 카메라/갤러리에서 이미지 선택 |

### 마이페이지 (FeatureMyPage)
| 기능 | 설명 |
|------|------|
| 사용자 프로필 | 프로필 이미지, 닉네임 표시 |
| 사용자 정보 수정 | 닉네임, 프로필 이미지 변경 |
| 반려견(콤비) 관리 | 콤비 정보 수정, 콤비 추가 (최대 2마리) |
| 공지사항 | 공지/이벤트 목록, 읽지 않은 알림 뱃지 |
| 설정 | 알림 설정, 로그아웃, 회원 탈퇴 |
| 문의하기 | 1:1 문의 기능 |
| 앱 버전 정보 | 현재 버전 표시 |

### Apple Watch 연동 (FeatureWatch)
| 기능 | 설명 |
|------|------|
| WatchConnectivity | iOS ↔ watchOS 간 데이터 동기화 |
| 운동 시작/종료 | Watch에서 직접 운동 기록 |
| 콤비 선택 | 운동할 반려견 선택 |
| 운동 데이터 표시 | 시간, 거리 실시간 표시 |

## 2. 배포 상태

| 항목 | 내용 |
|------|------|
| 상태 | 운영 중 |
| 버전 | 1.2.1 (Build 23) |

## 3. 기술 스택

| 구분 | 기술 |
|------|------|
| 언어 | Swift 6.0 |
| UI | SwiftUI |
| 빌드 시스템 | Tuist 4.38.2 |
| 아키텍처 | Clean Architecture + MVVM |
| 의존성 주입 | swift-dependencies |
| 네트워킹 | Alamofire |
| 이미지 로딩 | Kingfisher |
| 지도 | Google Maps SDK |
| 소셜 로그인 | Kakao SDK |
| 애니메이션 | Lottie |
| 보안 저장소 | KeychainAccess |
| 리소스 코드젠 | R.swift |

## 4. 아키텍처 개요

```
┌─────────────────────────────────────────────────────┐
│                    App Layer                        │
│  (RunCombi iOS App, RunCombiWatch watchOS App)      │
└─────────────────────────────────────────────────────┘
                         │
┌─────────────────────────────────────────────────────┐
│                  Feature Layer                      │
│  Splash, Login, Main, Exercise, Calendar,           │
│  Record, MyPage, SignUp, Watch                      │
└─────────────────────────────────────────────────────┘
                         │
┌─────────────────────────────────────────────────────┐
│                  Domain Layer                       │
│  DomainLogin, DomainExercise, DomainCalendar,       │
│  DomainMyPage, DomainSignUp                         │
└─────────────────────────────────────────────────────┘
                         │
┌─────────────────────────────────────────────────────┐
│                   Core Layer                        │
│  CoreNetwork (Alamofire 기반 API 통신)              │
└─────────────────────────────────────────────────────┘
                         │
┌─────────────────────────────────────────────────────┐
│                  Shared Layer                       │
│  SharedUtility, UserInterface, ResourceKit          │
└─────────────────────────────────────────────────────┘
```

**외부 서비스 연동:**
- Google Maps: 운동 경로 표시
- Kakao OAuth: 소셜 로그인

## 5. 디렉토리 구조

```
RunCombi_iOS/
├── Projects/
│   ├── App/                    # 앱 엔트리포인트
│   │   ├── Sources/            # iOS 앱 소스
│   │   ├── Watch/              # watchOS 앱 소스
│   │   ├── Resources/          # 앱 리소스 (Assets, JSON 등)
│   │   └── Derived/            # 생성된 Info.plist
│   │
│   ├── Feature/                # 기능 모듈 (UI Layer)
│   │   ├── Splash/             # 스플래시 화면
│   │   ├── Login/              # 로그인/인증
│   │   ├── Main/               # 메인 탭 네비게이션
│   │   ├── Exercise/           # 운동 기록 (지도, 타이머)
│   │   ├── Calendar/           # 캘린더 뷰
│   │   ├── Record/             # 운동 기록 상세
│   │   ├── MyPage/             # 마이페이지/설정
│   │   ├── SignUp/             # 회원가입
│   │   └── Watch/              # watchOS 연동
│   │
│   ├── Domain/                 # 도메인 모듈 (Business Logic)
│   │   ├── Login/
│   │   ├── Exercise/
│   │   ├── Calendar/
│   │   ├── MyPage/
│   │   └── SignUp/
│   │
│   ├── Core/
│   │   └── Network/            # API 통신 레이어
│   │
│   ├── Shared/
│   │   └── Utility/            # 공통 유틸리티
│   │
│   └── DesignSystem/
│       ├── UserInterface/      # UI 컴포넌트
│       │   └── ResourceKit/    # R.swift 리소스
│       └── LocalizableStringManager/  # 다국어 문자열
│
├── Tuist/
│   ├── Package.swift           # SPM 의존성 정의
│   └── ProjectDescriptionHelpers/  # Tuist 헬퍼
│
├── Tuist.swift                 # Tuist 설정
├── Workspace.swift             # 워크스페이스 정의
└── .mise.toml                  # 도구 버전 관리
```

## 6. 개발 환경 세팅

### 필수 도구

```bash
# mise 설치 (도구 버전 관리)
brew install mise

# 프로젝트 디렉토리에서 mise 활성화
cd RunCombi_iOS
mise install
```

### Tuist 설치

```bash
# mise가 .mise.toml 기반으로 Tuist 4.38.2 설치
mise install tuist@4.38.2
```

### Xcode

- **최소 버전**: Xcode 16.0+ (Swift 6.0 지원)
- iOS 17.0 SDK, watchOS 9.0 SDK 필요