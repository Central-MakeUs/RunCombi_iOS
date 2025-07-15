//
//  WalkStyleType.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

enum WalkStyleType: String, CaseIterable {
  case none = ""
  case energetic = "에너지가 넘쳐요!"
  case relaxed = "여유롭게 걸어요"
  case slow = "천천히 걸으며 자주 쉬어요"
  
  var serverValue: String {
    switch self {
    case .none:
      ""
    case .energetic:
      "RUNNING"
    case .relaxed:
      "WALKING"
    case .slow:
      "SLOW_WALKING"
    }
  }
}
