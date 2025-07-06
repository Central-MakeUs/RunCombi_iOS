//
//  DogNameInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct DogNameInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 35) {
      Button {
        
      } label: {
        Image(R.image.dog)
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
          Text("한글 6자/ 영문 10자 이하")
            .pretendardFont(size: 12, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        }
        
        TextField(
          "",
          text: $viewModel.state.typpedDogName,
          prompt: Text("콤비")
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
      
      VStack(spacing: 32) {
        Text("다른 반려견도 나중에 추가할 수 있어요")
          .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
        
        Button {
          viewModel.navigate(action: .didTapDogInfoInputButton(.body))
        } label: {
          PrimaryActionLabel(
            text: String(key: "Common.Next"),
            backgroundColor: viewModel.state.typpedDogName.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
          )
        }
        .disabled(viewModel.state.typpedDogName.isEmpty)
      }
    }
  }
}
