//
//  BodyInfoInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct BodyInfoInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 78) {
      VStack(spacing: 9) {
        Text("신체 정보를 알려주세요")
          .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("외부에 공개되지 않아요")
          .pretendardFont(size: 22, weight: .medium, lineHeight: 24)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      VStack(spacing: 27) {
        HStack {
          Text("키")
            .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          
          Spacer()
          
          HStack {
            TextField(
              "",
              text: $viewModel.state.typpedHeight,
              prompt: Text("165")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.numberPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 14, weight: .semiBold, lineHeight: 24)
            
            Spacer(minLength: 4)
            
            Text("cm")
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 24)
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
              text: $viewModel.state.typpedWeight,
              prompt: Text("50")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.numberPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 14, weight: .semiBold, lineHeight: 24)
            
            Spacer(minLength: 4)
            
            Text("kg")
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 24)
          }
          .frame(maxWidth: 134)
          .padding(.horizontal, 12)
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 6))
        }
      }
    }
    .onAppear {
      UIApplication.shared.hideKeyboard()
    }
    
    Spacer()
    
    NavigationLink {
      DogInfoInputView(of: viewModel)
    } label: {
      PrimaryActionLabel(
        text: String(key: "Common.Next"),
        backgroundColor: viewModel.state.typpedHeight.isEmpty || viewModel.state.typpedWeight.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
      )
    }
    .disabled(viewModel.state.typpedHeight.isEmpty || viewModel.state.typpedWeight.isEmpty)
  }
}
