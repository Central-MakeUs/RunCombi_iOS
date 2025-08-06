//
//  CalendarView.swift
//  FeatureRecord
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainCalendar
import FeatureRecord
import ResourceKit
import SharedUtility
import UserInterface

struct CalendarView: View {
  @Dependency(\.calendarClient) var calendarClient
  @EnvironmentObject var userManager: UserManager

  @State private var currentDate = Date()
  @State private var fetchMonthData: MonthDataResult?
  @State private var workoutDays: Set<Int> = []
  @State private var isRecordSheetPresented = false
  @State private var isAddRecordView = false
  @State private var selectedDate: Date?
  @State private var selectedDayData: DayDataResult?
  @Binding var snackBarItem: String
  
  var body: some View {
    VStack(spacing: 44) {
      CalendarInfoSection(fetchMonthData: $fetchMonthData)
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
              let isSelected = Date().isSameDay(as: day)
              
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
                isRecordSheetPresented = true
                selectedDate = isSelected ? nil : day
                BottomSheetPresenter.shared.show(isPresented: $isRecordSheetPresented) {
                  RecordBottomSheet(
                    selectedDate: day,
                    isSheetPresented: $isRecordSheetPresented,
                    isAddRecordView: $isAddRecordView,
                    selectedDayData: $selectedDayData
                  )
                }
              }
            } else {
              Color.clear.frame(width: 40, height: 50)
            }
          }
        }
      }
      .background(Color(R.color.greyscale_01_171717))
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .padding(.top, 36)
    .task {
      await fetchMonthData(for: currentDate)
    }
    .navigationDestination(item: $selectedDayData) { data in
      RecordDetailView(of: data.runId, snackBarItem: $snackBarItem)
    }
    .fullScreenCover(isPresented: $isAddRecordView) {
      AddRecordView(of: $selectedDate, snackBarItem: $snackBarItem, isPresented: $isAddRecordView) {
        Task {
          await fetchMonthData(for: currentDate)
        }
      }
    }
    .overlay(
      Group {
        if snackBarItem.isEmpty == false {
          HStack {
            Image(R.image.checkBox)
            Text(snackBarItem)
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            Spacer()
          }
          .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 8))
          .transition(.move(edge: .top).combined(with: .opacity))
          .task {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
              withAnimation {
                snackBarItem = ""
              }
            }
          }
        }
      }
      .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)), alignment: .top
    )
  }
  
  private func changeMonth(by offset: Int) {
    guard let newDate = Calendar.current.date(byAdding: .month, value: offset, to: currentDate) else { return }
    currentDate = newDate
    Task {
      await fetchMonthData(for: newDate)
    }
  }
  
  private func fetchMonthData(for date: Date) async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      let year = Calendar.current.component(.year, from: date)
      let month = Calendar.current.component(.month, from: date)
      fetchMonthData = try await calendarClient.fetchMonthData(token: token, year: year, month: month)
      
      if let fetchMonthData {
        let daysWithRun = fetchMonthData.monthData.compactMap { item -> Int? in
          guard let date = DateFormatter.yyyyMMdd.date(from: item.date) else { return nil }
          return Calendar.current.component(.day, from: date)
        }
        DispatchQueue.main.async {
          Logger.d("\(daysWithRun)")
          self.workoutDays = Set(daysWithRun)
        }
      }
    } catch {
      Logger.e("\(error)")
    }
  }
}
