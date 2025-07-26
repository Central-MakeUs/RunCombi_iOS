//
//  SurveyType.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

enum SurveyType: CaseIterable {
  case none
  case organizeRecords       // "기록을 정리하고 싶어요"
  case difficultUsage        // "사용 방법이 어려워요"
  case lackingFeatures       // "기능이 부족하거나 불편했어요"
  case infrequentUsage       // "자주 쓰지 않게 되었어요"
  case other                 // "기타"
}

extension SurveyType {
  var text: String {
    switch self {
    case .none:
        ""
    case .organizeRecords:
      "기록을 정리하고 싶어요"
    case .difficultUsage:
      "사용 방법이 어려워요"
    case .lackingFeatures:
      "기능이 부족하거나 불편했어요"
    case .infrequentUsage:
      "자주 쓰지 않게 되었어요"
    case .other:
      "기타"
    }
  }
}
