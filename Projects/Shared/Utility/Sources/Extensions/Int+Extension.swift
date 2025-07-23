//
//  Int+Extension.swift
//  SharedUtility
//
//  Created by Groonui on 7/23/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public extension Int {
  /// 초(second) 단위 정수를 시간 문자열로 변환
  /// - 1시간 미만: "MM:SS"
  /// - 1시간 이상: "HH:MM:SS"
  func toTimeString() -> String {
    let total = self
    let hours = total / 3600
    let minutes = (total % 3600) / 60
    let seconds = total % 60
    
    if hours > 0 {
      return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    } else {
      return String(format: "%02d:%02d", minutes, seconds)
    }
  }
}
