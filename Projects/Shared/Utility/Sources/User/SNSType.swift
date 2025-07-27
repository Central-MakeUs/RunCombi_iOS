//
//  SNSType.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/27/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public enum SNSType {
  case none
  case kakao
  case apple
  
  public static func convertSNSType(_ SNSString: String) -> SNSType {
    switch SNSString {
    case "KAKAO":
      return .kakao
    case "APPLE":
      return .apple
    default:
      return .none
    }
  }
}
