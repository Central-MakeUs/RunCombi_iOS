//
//  GenderInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct GenderInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 9) {
      Text("성별이 어떻게 되시나요?")
        .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
        .foregroundStyle(Color(R.color.white_FFFFFF))
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Text("외부에 공개되지 않아요")
        .pretendardFont(size: 22, weight: .medium, lineHeight: 24)
        .foregroundStyle(Color(R.color.greyscale_06_999999))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    Spacer()
    
    VStack(spacing: 14) {
      Button {
        selectGender(to: .male)
      } label: {
        PrimaryActionLabel(
          text: String(key: "남성"),
          foregroundColor: viewModel.state.selectedGender == .male ? Color(R.color.greyscale_03_3B3B3B): Color(R.color.white_FFFFFF),
          backgroundColor: viewModel.state.selectedGender == .male ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_04_525252)
        )
      }
      
      Button {
        selectGender(to: .female)
      } label: {
        PrimaryActionLabel(
          text: String(key: "여성"),
          foregroundColor: viewModel.state.selectedGender == .female ? Color(R.color.greyscale_03_3B3B3B): Color(R.color.white_FFFFFF),
          backgroundColor: viewModel.state.selectedGender == .female ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_04_525252)
        )
      }
    }
  }
}

private extension GenderInputView {
  func selectGender(to gender: GenderType) {
    viewModel.send(action: .didTapGender(gender))
    viewModel.navigate(action: .didTapUserInfoInputButton(.body))
  }
}
