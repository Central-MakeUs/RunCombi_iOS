//
//  WalkStyleType.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum WalkStyleType: String, CaseIterable {
  case none = ""
  case energetic = "에너지가 넘쳐요!"
  case relaxed = "여유롭게 걸어요"
  case slow = "천천히 걸으며 자주 쉬어요"
  
  public static func convertWalkStyleType(_ serverValue: String) -> WalkStyleType {
    switch serverValue {
    case "RUNNING":
      return .energetic
    case "WALKING":
      return .relaxed
    case "SLOW_WALKING":
      return .slow
    default:
      return .none
    }
  }
  
  public var serverValue: String {
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
  
  public var dogFactor: Double {
    switch self {
    case .none:
      0
    case .energetic:
      6.4
    case .relaxed:
      4.8
    case .slow:
      3.2
    }
  }
  
  public var memberRunStyle: String {
    switch self {
    case .none:
      ""
    case .energetic:
      "조깅"
    case .relaxed:
      "빠른 걷기"
    case .slow:
      "걷기"
    }
  }
  
  public var maleMET: Double {
    switch self {
    case .none:
      0
    case .energetic:
      7.5
    case .relaxed:
      4.8
    case .slow:
      3.5
    }
  }
  
  public var femaleMET: Double {
    switch self {
    case .none:
      0
    case .energetic:
      7.0
    case .relaxed:
      4.2
    case .slow:
      3.0
    }
  }
}
