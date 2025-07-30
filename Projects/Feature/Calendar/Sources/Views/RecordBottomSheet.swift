//
//  RecordBottomSheet.swift
//  FeatureCalendar
//
//  Created by 임경빈 on 7/29/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct RecordBottomSheet: View {
  let selectedDate: Date
  
  var body: some View {
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
    }
    .background(Color(R.color.greyscale_02_252525))
    .padding(.horizontal, 20)
    .padding(.vertical, 12)
  }
}
