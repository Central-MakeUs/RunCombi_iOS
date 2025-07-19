//
//  EditType.swift
//  FeatureMyPage
//
//  Created by Groonui on 7/19/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

enum EditType {
  case name
  case height
  case weight
}

extension EditType {
  var title: String {
    switch self {
    case .name:
      return "닉네임"
    case .height:
      return "키 (cm)"
    case .weight:
      return "체중 (kg)"
    }
  }
  
  var placehoder: String {
    switch self {
    case .name:
      return "런콤비"
    case .height:
      return "160"
    case .weight:
      return "55"
    }
  }
  
  var keyboardType: UIKeyboardType {
    switch self {
    case .name:
        .default
    case .height:
        .numberPad
    case .weight:
        .numberPad
    }
  }
}
