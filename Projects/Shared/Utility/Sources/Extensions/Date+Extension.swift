//
//  Date+Extension.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/30/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public extension Date {
  func toServerDateString() -> String {
    let formatter = DateFormatter()
    formatter.timeZone = .current
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    let base = formatter.string(from: self)
    
    // 2) Date의 fractional part를 꺼내서 μs 단위로 계산
    let interval = self.timeIntervalSince1970
    let seconds = floor(interval)
    let fraction = Int((interval - seconds) * 1_000_000)
    
    // 3) 0 → 1로 치환하거나, 그대로 6자리 zero-pad
    let micro = fraction == 0 ? 1 : fraction
    let fracStr = String(format: ".%06d", micro)
    return base + fracStr
  }
  
  func monthYearString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 M월"
    return formatter.string(from: self)
  }
  
  func dayMonthYearString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 M월 d일"
    return formatter.string(from: self)
  }
  
  func generateMonthGrid() -> [Date?] {
    var calendar = Calendar.current
    calendar.locale = Locale(identifier: "ko_KR")
    calendar.firstWeekday = 1 // Sunday
    
    let range = calendar.range(of: .day, in: .month, for: self)!
    let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    let startWeekday = calendar.component(.weekday, from: startOfMonth)
    let prefixEmpty = startWeekday - 1 // 요일 보정
    
    var days: [Date?] = Array(repeating: nil, count: prefixEmpty)
    for day in range {
      if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
        days.append(date)
      }
    }
    return days
  }
  
  var dayNumber: Int {
    Calendar.current.component(.day, from: self)
  }
  
  func isSameDay(as other: Date) -> Bool {
    Calendar.current.isDate(self, inSameDayAs: other)
  }
}
