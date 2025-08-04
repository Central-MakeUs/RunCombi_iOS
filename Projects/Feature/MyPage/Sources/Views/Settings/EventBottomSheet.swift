//
//  EventBottomSheet.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 8/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct EventBottomSheet: View {
  @Binding var isPresented: Bool
  @State private var code = "asdfasdf" // TODO: - 하드 코딩
  @State private var isCopying = false
  
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        HStack {
          Text("이벤트 응모")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
            .foregroundColor(Color(R.color.white_FFFFFF))
          
          Spacer()
          
          Button {
            isPresented = false
          } label: {
            Image(R.image.xmark)
          }
        }
        
        Text("아래 코드를 복사한 후, 응모 폼에 붙여넣어주세요.")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        HStack {
          Text(code)
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
          
          Spacer()
          
          Button {
            UIPasteboard.general.string = code
            isCopying = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              withAnimation {
                isCopying = false
              }
            }
          } label: {
            HStack(spacing: 4) {
              isCopying ? Image(R.image.check) : Image(R.image.copy)
              
              Text("복사하기")
                .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
                .foregroundStyle(Color(R.color.blue_398AEC))
            }
          }
          .disabled(isCopying)
        }
        .padding(.horizontal, 16)
        .frame(height: 40)
        .background(Color(R.color.greyscale_03_333333))
        .clipShape(.rect(cornerRadius: 6))
      }
      
      Button {
        // TODO: - 응모하기 화면으로 랜딩
        isPresented = false
      } label :{
        PrimaryActionLabel(
          text: "응모하기",
          height: 48,
          backgroundColor: Color(R.color.primary_01_D7FE63)
        )
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
}
