//
//  FirebaseAnalyticsBackend.swift
//  RunCombi
//
//  Created by Groonui on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import FirebaseAnalytics
import SharedUtility

/// AppAnalytics의 Firebase 구현체 (App 타겟에서만 Firebase 의존)
struct FirebaseAnalyticsBackend: AnalyticsBackend {
  func log(name: String, params: [String: Any]?) {
    Analytics.logEvent(name, parameters: params)
  }

  func setUserProperty(_ value: String?, name: String) {
    Analytics.setUserProperty(value, forName: name)
  }
}
