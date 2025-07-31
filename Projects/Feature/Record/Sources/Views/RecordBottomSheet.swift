//
//  RecordBottomSheet.swift
//  FeatureCalendar
//
//  Created by 임경빈 on 7/29/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainCalendar
import Kingfisher
import ResourceKit
import SharedUtility
import UserInterface

public struct RecordBottomSheet: View {
  @Environment(\.dismiss) var dismiss
  @Dependency(\.calendarClient) var calendarClient
  let selectedDate: Date
  @Binding var isSheetPresented: Bool
  @Binding var selectedDayData: DayDataResult?
  
  @State private var dayData: [DayDataResult] = []
  
  public init(selectedDate: Date, isSheetPresented: Binding<Bool>, selectedDayData: Binding<DayDataResult?>) {
    self.selectedDate = selectedDate
    self._isSheetPresented = isSheetPresented
    self._selectedDayData = selectedDayData
  }
  
  public var body: some View {
    VStack(spacing: 16) {
      HStack {
        Text(selectedDate.dayMonthYearString())
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.white_FFFFFF))
        
        Spacer()
        
        Button {
          // TODO: - 운동 기록 추가
        } label: {
          Image(R.image.plus)
        }
      }
      
      if dayData.isEmpty {
        Text("운동 기록이 텅~")
          .giantsFont(size: 16, weight: .regular, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_04_525252))
          .padding(.vertical, 33)
          .frame(maxWidth: .infinity)
          .overlay(
            RoundedRectangle(cornerRadius: 6)
              .stroke(style: StrokeStyle(
                lineWidth: 3,
                lineCap: .round,
                lineJoin: .round,
                dash: [6, 6]    // [실선 길이, 공백 길이]
              ))
              .foregroundColor(Color(R.color.greyscale_03_333333))
          )
          .padding(.bottom, 12)
      } else {
        ScrollView {
          VStack(spacing: 12) {
            ForEach(dayData, id: \.self) { data in
              HStack {
                VStack(alignment: .leading, spacing: 4) {
                  HStack(spacing: 4) {
                    Image(R.image.clock)
                    Text((data.regDate.toHourMinuteFormat()).ifNil(then: ""))
                      .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
                      .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                  }
                  HStack(spacing: 32) {
                    VStack(spacing: .zero) {
                      DayRecordItem(title: "운동 시간", value: String(data.runTime), unit: "min")
                    }
                    VStack(spacing: .zero) {
                      DayRecordItem(title: "운동 거리", value: String(data.runDistance), unit: "km")
                    }
                  }
                }
                Spacer()
                if let imageURL = URL(string: data.runImageUrl) {
                  KFImage(imageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .clipShape(.rect(cornerRadius: 5))
                }
              }
              .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 12))
              .background(Color(R.color.greyscale_03_333333))
              .clipShape(.rect(cornerRadius: 6))
              .onTapGesture {
                isSheetPresented = false
                selectedDayData = data
              }
            }
          }
          .padding(.bottom, getSafeArea().bottom)
        }
        .scrollIndicators(.never)
        .frame(maxHeight: 220)
      }
    }
    .padding(.horizontal, 20)
    .padding(.top, 12)
    .task {
      await fetchDayData(for: selectedDate)
    }
  }
  
  private func fetchDayData(for date: Date) async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      let year = Calendar.current.component(.year, from: date)
      let month = Calendar.current.component(.month, from: date)
      let day = Calendar.current.component(.day, from: date)
      dayData = try await calendarClient.fetchDayData(token: token, year: year, month: month, day: day)
    } catch {
      Logger.e("\(error)")
    }
  }
}

struct DayRecordItem: View {
  let title: String
  let value: String
  var unit: String = ""
  
  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
        .foregroundColor(Color(R.color.greyscale_06_999999))
      HStack(alignment: .bottom, spacing: 4) {
        Text(value)
          .giantsFont(size: 16, weight: .regular, lineHeight: 26)
          .foregroundColor(Color(R.color.white_FFFFFF))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
        Text(unit)
          .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
          .foregroundColor(Color(R.color.greyscale_06_999999))
      }
    }
  }
}
