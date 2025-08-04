//
//  String+Extension.swift
//  SharedUtility
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public extension String {
  func isLetterWithBase() -> String {
    // 1) 빈 문자열 → 받침 없음
    guard let lastChar = self.last else {
        return "와"
    }
    // 2) Character의 첫 유니코드 스칼라값 가져오기
    guard let scalar = lastChar.unicodeScalars.first else {
        return "와"
    }
    let value = scalar.value
    // 3) 한글 완성형 음절 블록(0xAC00…0xD7A3)인지 확인
    guard (0xAC00...0xD7A3).contains(value) else {
        return "와"
    }
    // 4) 음절 인덱스 계산 후 28로 나눈 나머지가 0이면 받침 없음
    let syllableIndex = value - 0xAC00
    let jong = syllableIndex % 28
    return jong != 0 ? "과" : "와"
  }
  
  func toDate() -> Date? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    isoFormatter.timeZone = .current
    
    guard let date = isoFormatter.date(from: self) else {
      // fallback: try with normal DateFormatter if ISO fails
      let fallbackFormatter = DateFormatter()
      fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
      fallbackFormatter.timeZone = .current
      if let fallbackDate = fallbackFormatter.date(from: self) {
        return fallbackDate
      }
      return nil
    }

    return date
  }
  
  /// ISO8601 날짜 문자열을 "HH : mm" 포맷으로 변환 (마이크로초 대응)
  func toHourMinuteFormat() -> String? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
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
  
  func toKoreanDateFormat() -> String? {
    let isoFormatter = ISO8601DateFormatter()
    isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

    guard let date = isoFormatter.date(from: self) else {
      // fallback
      let fallbackFormatter = DateFormatter()
      fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
      fallbackFormatter.timeZone = TimeZone(secondsFromGMT: 0)
      if let fallbackDate = fallbackFormatter.date(from: self) {
        return fallbackDate.toKoreanDate()
      }
      return nil
    }

    return date.toKoreanDate()
  }
}

extension Date {
  func toHourMinute() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "HH : mm"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter.string(from: self)
  }
  
  func toKoreanDate() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.dateFormat = "yyyy년 M월 d일"
    return formatter.string(from: self)
  }
}
