//
//  CancelRecordBottomSheet.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct CancelRecordBottomSheet: View {
  @Environment(\.dismiss) var dismiss
  @Binding var isPresented: Bool
  
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        Text("기록 작성을 그만두시겠어요?")
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("지금까지 입력한 내용은 저장되지 않아요.")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      HStack(spacing: 10) {
        Button {
          dismiss()
        } label: {
          PrimaryActionLabel(
            text: "취소",
            foregroundColor: Color(R.color.white_FFFFFF),
            backgroundColor: Color(R.color.error_FC5555)
          )
        }
        
        Button {
          isPresented = false
        } label: {
          PrimaryActionLabel(
            text: "아니요",
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
    
  }
}
