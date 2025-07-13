//
//  NameInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation
import SwiftUI

import ResourceKit
import UserInterface
import SharedUtility

struct NameInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  @State private var errorMessage: String?
  @State private var lastValidNickname: String = ""
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 35) {
      SelectImageView(type: .user, selectedImageData: $viewModel.state.selectedUserImageData)
      
      VStack(spacing: 5) {
        HStack {
          Text("이름")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          Spacer()
          //FC5555
          Text(errorMessage.ifNil(then: "한글 5자/ 영문 7자 이하"))
            .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
            .foregroundStyle(errorMessage == nil ? Color(R.color.greyscale_06_999999) : Color(R.color.error_FC5555))
        }
        
        TextField(
          "",
          text: $viewModel.state.typpedNickname,
          prompt: Text("런콤비")
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
        .onChange(of: viewModel.state.typpedNickname) { oldValue, newValue in
          handleNicknameChange(oldValue: oldValue, newValue: newValue)
        }
      }
      
      Spacer()
      
      Button {
        viewModel.navigate(action: .didTapUserInfoInputButton(.gender))
      } label: {
        PrimaryActionLabel(
          text: String(key: "Common.Next"),
          backgroundColor: viewModel.state.typpedNickname.isEmpty || errorMessage != nil ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
        )
      }
      .disabled(viewModel.state.typpedNickname.isEmpty || errorMessage != nil)
    }
  }
  
  private func handleNicknameChange(oldValue: String, newValue: String) {
    // 1) 되돌린 값이면 아무것도 안 함
    guard newValue != lastValidNickname else { return }
    
    // 2) 유효성 검사
    do {
      try NameValidator.validate(newValue)
      // 통과 시
      lastValidNickname = newValue
      errorMessage = nil
    } catch let error as NameValidationError {
      // 실패 시
      errorMessage = error.errorDescription
      // 뷰모델 값 되돌리기
      viewModel.state.typpedNickname = lastValidNickname
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}
