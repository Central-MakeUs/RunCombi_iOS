//
//  EditType.swift
//  FeatureMyPage
//
//  Created by Groonui on 7/19/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

enum EditType {
  case userName
  case userHeight
  case userWeight
  
  case combiName
  case combiAge
  case combiWeight
}

extension EditType {
  var title: String {
    switch self {
    case .userName:
      return "닉네임"
    case .userHeight:
      return "키 (cm)"
    case .userWeight:
      return "체중 (kg)"
    case .combiName:
      return "닉네임"
    case .combiAge:
      return "나이 (살)"
    case .combiWeight:
      return "체중 (kg)"
    }
  }
  
  var placehoder: String {
    switch self {
    case .userName:
      return "런콤비"
    case .userHeight:
      return "160"
    case .userWeight:
      return "55"
    case .combiName:
      return "콤비"
    case .combiAge:
      return "5"
    case .combiWeight:
      return "5.5"
    }
  }
  
  var keyboardType: UIKeyboardType {
    switch self {
    case .userName, .combiName:
        .default
    case .userHeight, .userWeight, .combiWeight:
        .numberPad
    case .combiAge:
        .decimalPad
    }
  }
}
