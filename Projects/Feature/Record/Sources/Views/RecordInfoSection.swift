//
//  RecordInfoSection.swift
//  FeatureRecord
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct RecordInfoSection: View {
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Text("이번 달 운동 기록이 텅~")
        .font(.system(size: 20, weight: .bold))
        .foregroundColor(.white)

      HStack(spacing: 0) {
        RecordItem(title: "평균 운동 시간", value: "- ", unit: "min")
        Spacer()
        RecordItem(title: "평균 운동 거리", value: "-.-- ", unit: "km")
        Spacer()
        RecordItem(title: "자주한 운동", value: "---")
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
    .background(Color(R.color.greyscale_02_252525))
    .cornerRadius(6)
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
          .pretendardFont(size: 20, weight: .regular, lineHeight: 30)
          .foregroundColor(Color(R.color.greyscale_08_EDEDED))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
        Text(unit)
          .pretendardFont(size: 10, weight: .regular, lineHeight: 20)
          .foregroundColor(Color(R.color.greyscale_08_EDEDED))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
      }
    }
  }
}
