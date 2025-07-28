//
//  CalendarView.swift
//  FeatureRecord
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct CalendarView: View {
  @State private var currentDate = Date()
  @State private var selectedDate: Date? = nil
  
  // 예시로 운동한 날: 7월 1, 2, 3, 7, 9, 10, 14, 23, 28, 31일
  let workoutDays: Set<Int> = [1, 2, 3, 7, 9, 10, 14, 23, 28, 31]
  
  var body: some View {
    VStack(spacing: 16) {
      // Header
      HStack {
        HStack(spacing: 12) {
          Button(action: { changeMonth(by: -1) }) {
            Image(systemName: "chevron.left")
              .foregroundStyle(Color(R.color.greyscale_05_757575))
          }
          
          Text(currentDate.monthYearString())
            .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
            .frame(maxWidth: 80)
          
          Button(action: { changeMonth(by: 1) }) {
            Image(systemName: "chevron.right")
              .foregroundStyle(Color(R.color.greyscale_05_757575))
          }
        }
        
        Spacer()
        
        // 운동 횟수
        HStack {
          Image(systemName: "pawprint.fill")
            .foregroundColor(Color(hex: "#D2FF48"))
            .foregroundStyle(Color(R.color.primary_01_D7FE63))
          HStack(alignment: .bottom, spacing: .zero) {
            Text("\(workoutDays.count)")
              .giantsFont(size: 18, weight: .regular, lineHeight: 26)
              .foregroundStyle(Color(R.color.primary_01_D7FE63))
            Text(" 번")
              .giantsFont(size: 16, weight: .regular, lineHeight: 26)
              .foregroundStyle(Color(R.color.primary_01_D7FE63))
          }
        }
      }
      
      // 요일 헤더
      let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
      HStack {
        ForEach(weekdays, id: \.self) { day in
          Text(day)
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
            .frame(maxWidth: .infinity)
        }
      }
      
      // 날짜 그리드
      let days = currentDate.generateMonthGrid()
      LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 9) {
        ForEach(Array(days.enumerated()), id: \.offset) { index, day in
          if let day = day {
            let isWorkout = workoutDays.contains(day.dayNumber)
            let isSelected = currentDate.isSameDay(as: day)
            
            ZStack {
              if isWorkout {
                Image(systemName: "pawprint.fill")
                  .foregroundStyle(isSelected ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_07_B3B3B3))
              } else {
                Text("\(day.dayNumber)")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_05_757575))
              }
            }
            .frame(width: 40, height: 50)
            .background(Color(R.color.greyscale_02_252525))
            .clipShape(.rect(cornerRadius: 2))
            .overlay {
              if isSelected {
                RoundedRectangle(cornerRadius: 2)
                  .strokeBorder(Color(R.color.primary_02_E8FFA3), lineWidth: 0.7)
                  .fill(.clear)
              }
            }
            .onTapGesture {
              selectedDate = day
            }
          } else {
            Color.clear.frame(width: 40, height: 50)
          }
        }
      }
    }
    .background(Color(R.color.greyscale_01_171717))
  }
  
  private func changeMonth(by offset: Int) {
    guard let newDate = Calendar.current.date(byAdding: .month, value: offset, to: currentDate) else { return }
    currentDate = newDate
  }
}


extension Date {
  func monthYearString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy년 M월"
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
