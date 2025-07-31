//
//  MemoView.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct MemoView: View {
  @Environment(\.dismiss) var dismiss
  @State private var typpedMemoText: String = ""
  @Binding var memoText: String
  @FocusState private var isFocused: Bool
  
  var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 24) {
        VStack(spacing: 4) {
          Text("메모")
            .pretendardFont(size: 24, weight: .semiBold, lineHeight: 36)
            .foregroundStyle(Color(R.color.white_FFFFFF))
            .frame(maxWidth: .infinity, alignment: .leading)
          Text("강아지와 함께한 운동은 어떠셨나요?")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 32)
        
        VStack(alignment: .trailing, spacing: 4) {
          TextEditor(text: $typpedMemoText)
            .focused($isFocused)
            .keyboardType(.alphabet)
            .disableAutocorrection(true)
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .frame(maxHeight: 200)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .scrollContentBackground(.hidden)
            .background(Color(R.color.greyscale_02_252525))
            .cornerRadius(4)
            .onChange(of: typpedMemoText) {
              if typpedMemoText.count > 100 {
                typpedMemoText = String(typpedMemoText.prefix(100))
              }
            }
            .overlay(alignment: .topLeading) {
              Text("오늘은 콩돌이랑 함께 한강을 산책했다")
                .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                .foregroundStyle(typpedMemoText.isEmpty ? Color(R.color.greyscale_04_525252) : .clear)
                .padding(.leading, 23)
                .padding(.top, 23)
            }
          
          HStack(spacing: .zero) {
            Text("\(typpedMemoText.count)")
              .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
              .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            Text("/100")
              .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
              .foregroundStyle(Color(R.color.white_FFFFFF).opacity(0.32))
          }
        }
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            dismiss()
          } label: {
            PrimaryActionLabel(text: "이전", foregroundColor: Color(R.color.greyscale_08_EDEDED), backgroundColor: Color(R.color.greyscale_04_525252))
          }
          
          Button {
            // TODO: - 메모 저장
            memoText = typpedMemoText
            dismiss()
          } label: {
            PrimaryActionLabel(
              text: "완료",
              foregroundColor: typpedMemoText.isEmpty ? Color(R.color.gray_090909): Color(R.color.greyscale_02_252525),
              backgroundColor: typpedMemoText.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
            )
          }
          .disabled(typpedMemoText.isEmpty)
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
    .onAppear {
      isFocused = true
      typpedMemoText = memoText
    }
  }
}
