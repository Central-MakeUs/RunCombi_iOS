//
//  ExerciseEvaluation.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

enum ExerciseEvaluation: String, CaseIterable, Identifiable {
  case none
  case soEasy      = "쏘이지"
  case easy        = "이지"
  case normal      = "보통"
  case breathHold  = "숨참"
  case hard        = "힘듦"
  
  var id: String { rawValue }
  
  public static func convertExerciseEvaluation(_ serverValue: String) -> ExerciseEvaluation {
    switch serverValue {
    case "SO_EASY":
      return .soEasy
    case "EASY":
      return .easy
    case "NORMAL":
      return .normal
    case "HARD":
      return .breathHold
    case "VERY_HARD":
      return .hard
    default:
      return .none
    }
  }
}

extension ExerciseEvaluation {
  var serverValue: String {
    switch self {
    case .none:
      ""
    case .soEasy:
      "SO_EASY"
    case .easy:
      "EASY"
    case .normal:
      "NORMAL"
    case .breathHold:
      "HARD"
    case .hard:
      "VERY_HARD"
    }
  }
  
  var image: Image {
    switch self {
    case .none:
      Image("")
    case .soEasy:
      Image(R.image.soEasy)
    case .easy:
      Image(R.image.easy)
    case .normal:
      Image(R.image.normal)
    case .breathHold:
      Image(R.image.tired)
    case .hard:
      Image(R.image.hard)
    }
  }
  
  var selectedImage: Image {
    switch self {
    case .none:
      Image("")
    case .soEasy:
      Image(R.image.soEasySelected)
    case .easy:
      Image(R.image.easySelected)
    case .normal:
      Image(R.image.normalSelected)
    case .breathHold:
      Image(R.image.tiredSelected)
    case .hard:
      Image(R.image.hardSelected)
    }
  }
}
