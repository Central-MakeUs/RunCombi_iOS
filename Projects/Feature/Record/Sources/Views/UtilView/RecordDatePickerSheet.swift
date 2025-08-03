//
//  RecordDatePickerSheet.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct RecordDatePickerSheet: View {
  @Binding var isPresented: Bool
  @Binding var startDate: Date
  @State var selectedDate = Date()
  
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        Text("시작 일시를 선택하세요")
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        
        DatePicker(
          "",
          selection: $selectedDate,
          displayedComponents: [.date, .hourAndMinute]
        )
        .colorScheme(.dark)
        .datePickerStyle(WheelDatePickerStyle())
        .labelsHidden()
        .frame(maxHeight: 200)
      }
      
      HStack(spacing: 10) {
        Button {
          isPresented = false
        } label :{
          PrimaryActionLabel(
            text: "취소",
            height: 48,
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }
        
        Button {
          startDate = selectedDate
          isPresented = false
        } label :{
          PrimaryActionLabel(
            text: "선택",
            height: 48,
            backgroundColor: Color(R.color.primary_01_D7FE63)
          )
        }
      }
    }
    .onAppear {
      selectedDate = startDate
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
}
