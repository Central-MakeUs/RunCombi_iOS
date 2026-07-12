//
//  AnalyticsEvent.swift
//  SharedUtility
//
//  Created by Groonui on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

/// 앱에서 발생하는 모든 커스텀 애널리틱스 이벤트 정의
/// - 이벤트 이름/파라미터를 한 곳에서 관리해 오타와 드리프트를 방지한다.
/// - 파라미터 값은 영어 enum 값만 사용하며 PII(토큰, 이메일, 자유 텍스트 원문)는 금지.
public enum AnalyticsEvent {
  // MARK: 인증/가입
  /// 로그인 성공 (GA4 표준 이벤트)
  case login(method: String)
  /// 회원가입 완료 (GA4 표준 이벤트)
  case signUp(method: String)
  /// 회원가입 스텝 진입 (퍼널 이탈 분석용)
  case signUpStep(step: String, stepNumber: Int)

  // MARK: 운동
  /// 운동 시작 API 성공
  case exerciseStart(walkStyle: String, petCount: Int)
  /// 운동 종료 API 성공 (북극성 지표)
  case exerciseComplete(durationMin: Int, distanceKm: Double, walkStyle: String, petCount: Int)
  /// 운동 종료 없이 이탈
  case exerciseCancel(elapsedMin: Int)

  // MARK: 수익화
  /// 쿠팡 배너 클릭
  case bannerClick(tab: String)

  // MARK: 캘린더
  /// 합계/평균 토글 전환
  case calendarStatToggle(mode: String)
  /// 월 이동 (swipe/button)
  case calendarMonthChange(direction: String, method: String)

  // MARK: 기록
  /// 기록 상세 진입 경로
  case recordView(source: String)
  /// 수동 기록 추가 성공
  case recordAdd(durationMin: Int, distanceKm: Double, petCount: Int, daysAgo: Int)
  /// 기록 수정 (memo/photo/evaluation/fields)
  case recordUpdate(type: String)
  /// 기록 삭제
  case recordDelete

  // MARK: 이탈/피드백
  /// 회원 탈퇴 (설문 사유 포함, 원문 금지)
  case accountDelete(reasons: String, hasOtherReason: Bool)
  /// 운동 후 피드백 제출
  case feedbackSubmit(lengthBucket: String)

  public var name: String {
    switch self {
    case .login: return "login"
    case .signUp: return "sign_up"
    case .signUpStep: return "sign_up_step"
    case .exerciseStart: return "exercise_start"
    case .exerciseComplete: return "exercise_complete"
    case .exerciseCancel: return "exercise_cancel"
    case .bannerClick: return "banner_click"
    case .calendarStatToggle: return "calendar_stat_toggle"
    case .calendarMonthChange: return "calendar_month_change"
    case .recordView: return "record_view"
    case .recordAdd: return "record_add"
    case .recordUpdate: return "record_update"
    case .recordDelete: return "record_delete"
    case .accountDelete: return "account_delete"
    case .feedbackSubmit: return "feedback_submit"
    }
  }

  public var params: [String: Any]? {
    switch self {
    case .login(let method):
      return ["method": method]
    case .signUp(let method):
      return ["method": method]
    case .signUpStep(let step, let stepNumber):
      return ["step": step, "step_number": stepNumber]
    case .exerciseStart(let walkStyle, let petCount):
      return ["walk_style": walkStyle, "pet_count": petCount]
    case .exerciseComplete(let durationMin, let distanceKm, let walkStyle, let petCount):
      return [
        "duration_min": durationMin,
        "distance_km": distanceKm,
        "walk_style": walkStyle,
        "pet_count": petCount
      ]
    case .exerciseCancel(let elapsedMin):
      return ["elapsed_min": elapsedMin]
    case .bannerClick(let tab):
      return ["tab": tab]
    case .calendarStatToggle(let mode):
      return ["mode": mode]
    case .calendarMonthChange(let direction, let method):
      return ["direction": direction, "method": method]
    case .recordView(let source):
      return ["source": source]
    case .recordAdd(let durationMin, let distanceKm, let petCount, let daysAgo):
      return [
        "duration_min": durationMin,
        "distance_km": distanceKm,
        "pet_count": petCount,
        "days_ago": daysAgo
      ]
    case .recordUpdate(let type):
      return ["type": type]
    case .recordDelete:
      return nil
    case .accountDelete(let reasons, let hasOtherReason):
      return ["reasons": reasons, "has_other_reason": hasOtherReason ? "true" : "false"]
    case .feedbackSubmit(let lengthBucket):
      return ["length_bucket": lengthBucket]
    }
  }
}

/// 세그먼테이션용 유저 프로퍼티
public enum AnalyticsUserProperty: String {
  case petCount = "pet_count"
  case loginMethod = "login_method"
  case watchPaired = "watch_paired"
}
