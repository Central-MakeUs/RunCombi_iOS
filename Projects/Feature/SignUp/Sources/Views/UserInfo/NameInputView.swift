//
//  NameInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct NameInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 26) {
      Button {
        
      } label: {
        Image(R.image.person)
          .overlay(alignment: .bottomTrailing) {
            Image(R.image.camera)
              .padding(.bottom, 9)
          }
      }
      
      VStack(spacing: 5) {
        HStack {
          Text("이름")
            .pretendardFont(size: 12, weight: .semiBold, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          Spacer()
          Text("한글 5자/ 영문 7자 이하")
            .pretendardFont(size: 12, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        }
        
        TextField(
          "",
          text: $viewModel.state.typpedNickname,
          prompt: Text("런콤비")
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        )
        .frame(height: 40)
        .pretendardFont(size: 12, weight: .semiBold, lineHeight: 24)
        .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
        .padding(.horizontal, 12)
        .background(Color(R.color.greyscale_04_525252))
        .clipShape(.rect(cornerRadius: 6))
      }
      
      Spacer()
      
      Button {
        viewModel.navigate(action: .didTapUserInfoInputButton(.gender))
      } label: {
        PrimaryActionLabel(
          text: String(key: "Common.Next"),
          backgroundColor: viewModel.state.typpedNickname.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
        )
      }
      .disabled(viewModel.state.typpedNickname.isEmpty)
    }
  }
}
