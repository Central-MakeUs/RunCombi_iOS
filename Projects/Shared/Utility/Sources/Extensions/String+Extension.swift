//
//  String+Extension.swift
//  SharedUtility
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public extension String {
  /// ISO8601 날짜 문자열을 "HH : mm" 포맷으로 변환 (마이크로초 대응)
  func toHourMinuteFormat() -> String? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    isoFormatter.timeZone = TimeZone(secondsFromGMT: 0) // or TimeZone.current
    
    guard let date = isoFormatter.date(from: self) else {
      // fallback: try with normal DateFormatter if ISO fails
      let fallbackFormatter = DateFormatter()
      fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
      fallbackFormatter.timeZone = TimeZone(secondsFromGMT: 0)
      if let fallbackDate = fallbackFormatter.date(from: self) {
        return fallbackDate.toHourMinute()
      }
      return nil
    }

    return date.toHourMinute()
  }
}
