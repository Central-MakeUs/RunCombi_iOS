//
//  EditTextField.swift
//  FeatureMyPage
//
//  Created by Groonui on 7/19/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct EditTextField: View {
  let type: EditType
  @Binding var typpedText: String
  @Binding var errorMessage: String?
  
  var body: some View {
    VStack(spacing: 6) {
      HStack {
        Text(type.title)
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
        Spacer()
        Text(errorMessage.ifNil(then: type == .name ? "한글 5자/ 영문 7자 이하" : ""))
          .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
          .foregroundStyle(errorMessage == nil ? Color(R.color.greyscale_06_999999) : Color(R.color.error_FC5555))
      }
      
      TextField(
        "",
        text: $typpedText,
        prompt: Text(type.placehoder)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
      )
      .keyboardType(type.keyboardType)
      .frame(height: 40)
      .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
      .foregroundStyle(errorMessage == nil ? Color(R.color.greyscale_08_EDEDED) : Color(R.color.error_FC5555))
      .padding(.horizontal, 12)
      .background(Color(R.color.greyscale_04_525252))
      .clipShape(.rect(cornerRadius: 6))
      .overlay(
        RoundedRectangle(cornerRadius: 6)
          .stroke(
            errorMessage == nil ? Color.clear : Color(R.color.error_FC5555),
            lineWidth: 1
          )
      )
    }
  }
}
