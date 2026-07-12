//
//  AppAnalytics.swift
//  SharedUtility
//
//  Created by Groonui on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

/// 애널리틱스 백엔드 추상화
/// - Feature/DesignSystem 모듈이 Firebase를 직접 의존하지 않도록 분리한다.
/// - 실제 구현(FirebaseAnalyticsBackend)은 App 타겟에만 존재한다.
public protocol AnalyticsBackend {
  func log(name: String, params: [String: Any]?)
  func setUserProperty(_ value: String?, name: String)
}

/// 앱 전역 애널리틱스 퍼사드
/// - 앱 시작 시 backend를 주입하면 활성화되고, 미주입 상태(워치 등)에서는 no-op으로 동작한다.
public final class AppAnalytics {
  public static let shared = AppAnalytics()
  private var backend: AnalyticsBackend?

  private init() {}

  /// 앱 시작 시 1회 호출 (예: FirebaseAnalyticsBackend 주입)
  public func register(backend: AnalyticsBackend) {
    self.backend = backend
  }

  public func log(_ event: AnalyticsEvent) {
    backend?.log(name: event.name, params: event.params)
  }

  /// SwiftUI는 자동 화면 추적이 동작하지 않으므로 수동으로 기록한다. (GA4 표준 screen_view)
  public func logScreen(_ name: String) {
    backend?.log(name: "screen_view", params: ["screen_name": name])
  }

  public func setUserProperty(_ property: AnalyticsUserProperty, value: String?) {
    backend?.setUserProperty(value, name: property.rawValue)
  }
}

public extension View {
  /// 화면 진입 시 screen_view 이벤트를 기록한다.
  func trackScreen(_ name: String) -> some View {
    onAppear {
      AppAnalytics.shared.logScreen(name)
    }
  }
}
