//
//  NetworkError.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum NetworkError: LocalizedError {
  case disconected
  
  public var errorDescription: String? {
    switch self {
    case .disconected:
      return "네트워크 연결 후 다시 시도해주세요."
    }
  }
}
