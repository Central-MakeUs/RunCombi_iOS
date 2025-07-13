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
import SharedUtility

struct DogNameInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  @State private var errorMessage: String?
  @State private var lastValidDogName: String = ""
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 35) {
      SelectImageView(type: .dog, selectedImageData: $viewModel.state.selectedDogImageData)
      
      VStack(spacing: 5) {
        HStack {
          Text("이름")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          Spacer()
          Text(errorMessage.ifNil(then: "한글 5자/ 영문 7자 이하"))
            .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
            .foregroundStyle(errorMessage == nil ? Color(R.color.greyscale_06_999999) : Color(R.color.error_FC5555))
        }
        
        TextField(
          "",
          text: $viewModel.state.typpedDogName,
          prompt: Text("콤비")
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        )
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
        .onChange(of: viewModel.state.typpedDogName) { oldValue, newValue in
          handleDogNameChange(oldValue: oldValue, newValue: newValue)
        }
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
            backgroundColor: viewModel.state.typpedDogName.isEmpty || errorMessage != nil ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
          )
        }
        .disabled(viewModel.state.typpedDogName.isEmpty || errorMessage != nil)
      }
    }
  }
  
  private func handleDogNameChange(oldValue: String, newValue: String) {
    // 1) 되돌린 값이면 아무것도 안 함
    guard newValue != lastValidDogName else { return }
    
    // 2) 유효성 검사
    do {
      try NameValidator.validate(newValue)
      // 통과 시
      lastValidDogName = newValue
      errorMessage = nil
    } catch let error as NameValidationError {
      // 실패 시
      errorMessage = error.errorDescription
      // 뷰모델 값 되돌리기
      viewModel.state.typpedDogName = lastValidDogName
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}
