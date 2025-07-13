//
//  ServerError.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum ServerError: LocalizedError {
  case serverError
  
  var localizedDescription: String {
    switch self {
    default:
      return "처리 중 에러가 발생했습니다."
    }
  }
}
