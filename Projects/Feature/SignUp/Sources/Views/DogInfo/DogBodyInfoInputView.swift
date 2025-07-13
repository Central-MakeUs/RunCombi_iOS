//
//  DogBodyInfoInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct DogBodyInfoInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 78) {
      VStack(spacing: 9) {
        Text("반려견 정보를 알려주세요")
          .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("외부에 공개되지 않아요")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      VStack(spacing: 27) {
        HStack {
          Text("나이")
            .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          
          Spacer()
          
          HStack {
            TextField(
              "",
              text: $viewModel.state.typpedDogAge,
              prompt: Text("5")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.numberPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            
            Spacer(minLength: 4)
            
            Text("살")
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          }
          .frame(maxWidth: 134)
          .padding(.horizontal, 12)
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 6))
        }
        
        HStack {
          Text("몸무게")
            .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          
          Spacer()
          
          HStack {
            TextField(
              "",
              text: $viewModel.state.typpedDogWeight,
              prompt: Text("8")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.decimalPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            
            Spacer(minLength: 4)
            
            Text("kg")
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          }
          .frame(maxWidth: 134)
          .padding(.horizontal, 12)
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 6))
        }
      }
    }
    
    Spacer()
    
    Button {
      viewModel.navigate(action: .didTapDogInfoInputButton(.walkStyle))
    } label: {
      PrimaryActionLabel(
        text: String(key: "Common.Next"),
        backgroundColor: viewModel.state.typpedDogAge.isEmpty || viewModel.state.typpedDogWeight.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
      )
    }
    .disabled(viewModel.state.typpedDogAge.isEmpty || viewModel.state.typpedDogWeight.isEmpty)
  }
}
