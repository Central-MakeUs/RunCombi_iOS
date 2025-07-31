//
//  Date+Extension.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/30/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public extension Date {
  func toHourMinute() -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "HH : mm"
    formatter.timeZone = TimeZone.current
    return formatter.string(from: self)
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
