//
//  DogBodyInfoInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility
import UserInterface

struct DogBodyInfoInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  var isButtonDisabled: Bool {
    viewModel.state.typpedDogAge.isEmpty ||
    viewModel.state.typpedDogWeight.isEmpty ||
    Int(viewModel.state.typpedDogAge).ifNil(then: 0) < 1 ||
    Int(viewModel.state.typpedDogAge).ifNil(then: 0) > 25 ||
    Double(viewModel.state.typpedDogWeight).ifNil(then: 0) < 0.5 ||
    Double(viewModel.state.typpedDogWeight).ifNil(then: 0) > 100
  }
  
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
            .onChange(of: viewModel.state.typpedDogAge) { oldValue, newValue in
              viewModel.state.typpedDogAge = validatedNumericInput(
                newValue: newValue,
                oldValue: oldValue
              )
            }
            
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
              prompt: Text("5.5")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .keyboardType(.decimalPad)
            .frame(height: 40)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .onChange(of: viewModel.state.typpedDogWeight) { oldValue, newValue in
              viewModel.state.typpedDogWeight = validatedDogWeightInput(
                newValue: newValue,
                oldValue: oldValue
              )
            }
            
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
        backgroundColor: isButtonDisabled ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
      )
    }
    .disabled(isButtonDisabled)
    .onAppear {
      AppAnalytics.shared.log(.signUpStep(step: "dog_body", stepNumber: 4))
    }
  }
  
  private func validatedNumericInput(newValue: String, oldValue: String) -> String {
    // 빈 문자열은 그대로 통과
    guard !newValue.isEmpty else { return newValue }
    // 숫자만 필터링
    let filtered = newValue.filter(\.isNumber)
    // 원본과 같고 Int 변환 가능하면 newValue, 아니면 oldValue
    return (filtered == newValue && Int(filtered) != nil) ? newValue : oldValue
  }
  
  private func validatedDogWeightInput(newValue: String, oldValue: String) -> String {
    // 1) 빈 문자열 입력은 그대로 허용 (사용자가 지우는 중일 때)
    guard !newValue.isEmpty else { return newValue }
    
    // 2) 숫자와 점(.) 이외의 문자가 섞여 있으면 이전 값으로
    let invalidChars = CharacterSet(charactersIn: "0123456789.").inverted
    guard newValue.rangeOfCharacter(from: invalidChars) == nil else {
      return oldValue
    }
    
    // 3) 점이 1개 초과 사용된 경우(“1.2.3”)는 이전 값으로
    let dotCount = newValue.filter { $0 == "." }.count
    guard dotCount <= 1 else {
      return oldValue
    }
    
    // 4) 소수점 뒤 자릿수가 1자리 초과면 이전 값으로
    if let dotIndex = newValue.firstIndex(of: ".") {
      let decimals = newValue[newValue.index(after: dotIndex)...]
      guard decimals.count <= 1 else {
        return oldValue
      }
    }
    
    // 5) Double 변환 후 범위 검사
    if let value = Double(newValue), value >= 0.5, value <= 100 {
      return newValue
    } else {
      return oldValue
    }
  }
}
