//
//  CalendarInfoSection.swift
//  FeatureRecord
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainCalendar
import ResourceKit
import SharedUtility
import UserInterface

struct CalendarInfoSection: View {
  @Binding var fetchMonthData: MonthDataResult?
  @State private var statMode: StatMode = .total
  @Namespace private var statModeNamespace

  enum StatMode: String, CaseIterable {
    case total = "합계"
    case average = "평균"

    var timeTitle: String { self == .total ? "총 운동 시간" : "평균 운동 시간" }
    var distanceTitle: String { self == .total ? "총 운동 거리" : "평균 운동 거리" }
  }

  var body: some View {
    Group {
      if let fetchMonthData, fetchMonthData.monthData.isEmpty == false {
        VStack(alignment: .leading, spacing: 20) {
          HStack(alignment: .top) {
            Group {
              Text("이번 달 ")
                .foregroundColor(.white)
              + Text("우리 콤비")
                .foregroundColor(Color(R.color.primary_01_D7FE63))
              + Text("는!")
                .foregroundColor(.white)
            }
            .giantsFont(size: 22, weight: .regular, lineHeight: 34)

            Spacer()

            statModePicker
          }

          HStack(spacing: 0) {
            RecordItem(
              title: statMode.timeTitle,
              value: "\(statMode == .total ? fetchMonthData.totalTime : fetchMonthData.avgTime)",
              unit: "min"
            )
            Spacer()
            RecordItem(
              title: statMode.distanceTitle,
              value: "\(statMode == .total ? fetchMonthData.totalDistance : fetchMonthData.avgDistance)",
              unit: "km"
            )
            Spacer()
            RecordItem(title: "자주한 운동", value: WalkStyleType.convertWalkStyleType(fetchMonthData.mostRunStyle).memberRunStyle)
          }
        }
      } else {
        VStack(alignment: .leading, spacing: 20) {
          Text("이번 달 운동 기록이 텅~")
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(.white)

          HStack(spacing: 0) {
            RecordItem(title: statMode.timeTitle, value: "- ", unit: "min")
            Spacer()
            RecordItem(title: statMode.distanceTitle, value: "-.-- ", unit: "km")
            Spacer()
            RecordItem(title: "자주한 운동", value: "---")
          }
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
    .background(Color(R.color.greyscale_02_252525))
    .cornerRadius(6)
  }

  private var statModePicker: some View {
    HStack(spacing: 0) {
      ForEach(StatMode.allCases, id: \.self) { mode in
        Text(mode.rawValue)
          .pretendardFont(size: 12, weight: .semiBold, lineHeight: 18)
          .foregroundColor(statMode == mode ? Color(R.color.greyscale_01_171717) : Color(R.color.greyscale_06_999999))
          .padding(.horizontal, 10)
          .padding(.vertical, 3)
          .background {
            if statMode == mode {
              Capsule()
                .fill(Color(R.color.primary_01_D7FE63))
                .matchedGeometryEffect(id: "statModeCapsule", in: statModeNamespace)
            }
          }
          .contentShape(Capsule())
          .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
              statMode = mode
            }
          }
      }
    }
    .padding(2)
    .background(Color(R.color.greyscale_01_171717))
    .clipShape(Capsule())
  }
}

struct RecordItem: View {
  let title: String
  let value: String
  var unit: String = ""

  var body: some View {
    VStack(spacing: 0) {
      Text(title)
        .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
        .foregroundColor(Color(R.color.greyscale_06_999999))
      HStack(alignment: .bottom, spacing: .zero) {
        Text(value)
          .giantsFont(size: 20, weight: .regular, lineHeight: 30)
          .foregroundColor(Color(R.color.greyscale_08_EDEDED))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
        Text(unit)
          .giantsFont(size: 10, weight: .regular, lineHeight: 20)
          .foregroundColor(Color(R.color.greyscale_08_EDEDED))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
      }
    }
  }
}
