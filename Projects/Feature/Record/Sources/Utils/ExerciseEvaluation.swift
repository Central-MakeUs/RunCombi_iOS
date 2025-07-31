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
}

extension ExerciseEvaluation {
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
