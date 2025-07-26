//
//  GenderType.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum GenderType: String {
  case none
  case male = "MALE"
  case female = "FEMALE"
  
  public static func convertGenderType(_ gender: String) -> GenderType {
    switch gender {
    case "MALE":
      return .male
    case "FEMALE":
      return .female
    default:
      return .none
    }
  }
}
