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
  var isButtonDisabled: Bool {
    viewModel.state.typpedHeight.isEmpty ||
    viewModel.state.typpedWeight.isEmpty ||
    Int(viewModel.state.typpedHeight).ifNil(then: 0) < 91 ||
    Int(viewModel.state.typpedHeight).ifNil(then: 0) > 242 ||
    Int(viewModel.state.typpedWeight).ifNil(then: 0) < 10 ||
    Int(viewModel.state.typpedWeight).ifNil(then: 0) > 227
  }
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 78) {
      VStack(spacing: 9) {
        Text("신체 정보를 알려주세요")
          .pretendardFont(size: 24, weight: .semiBold, lineHeight: 36)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("외부에 공개되지 않아요")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
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
              prompt: Text(viewModel.state.selectedGender == .male ? "172" :"160")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.numberPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 16, weight: .semiBold, lineHeight: 26)
            .onChange(of: viewModel.state.typpedHeight) { oldValue, newValue in
              viewModel.state.typpedHeight = validatedNumericInput(
                newValue: newValue,
                oldValue: oldValue
              )
            }
            
            Spacer(minLength: 4)
            
            Text("cm")
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .pretendardFont(size: 16, weight: .semiBold, lineHeight: 26)
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
              prompt: Text(viewModel.state.selectedGender == .male ? "68" :"55")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.numberPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 16, weight: .semiBold, lineHeight: 26)
            .onChange(of: viewModel.state.typpedWeight) { oldValue, newValue in
              viewModel.state.typpedWeight = validatedNumericInput(
                newValue: newValue,
                oldValue: oldValue
              )
            }
            
            Spacer(minLength: 4)
            
            Text("kg")
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .pretendardFont(size: 16, weight: .semiBold, lineHeight: 26)
          }
          .frame(maxWidth: 134)
          .padding(.horizontal, 12)
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 6))
        }
      }
    }
    
    Spacer()
    
    NavigationLink {
      DogInfoInputView(of: viewModel)
    } label: {
      PrimaryActionLabel(
        text: String(key: "Common.Next"),
        backgroundColor: isButtonDisabled ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
      )
    }
    .disabled(isButtonDisabled)
  }
  
  func validatedNumericInput(newValue: String, oldValue: String) -> String {
    // 빈 문자열은 그대로 통과
    guard !newValue.isEmpty else { return newValue }
    // 숫자만 필터링
    let filtered = newValue.filter(\.isNumber)
    // 원본과 같고 Int 변환 가능하면 newValue, 아니면 oldValue
    return (filtered == newValue && Int(filtered) != nil) ? newValue : oldValue
  }
}
