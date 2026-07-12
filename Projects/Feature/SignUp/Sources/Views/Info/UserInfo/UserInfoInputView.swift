//
//  UserInfoInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility
import UserInterface

struct UserInfoInputView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel: SignUpViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      InfoInputHeader(title: "사용자 정보", progress: viewModel.state.userInfoInputType.rawValue, isBackButtonPresented: viewModel.state.userInfoInputType != .nickname) {
        navgateBack()
      }
      .padding(.vertical, 34)
      
      switch viewModel.state.userInfoInputType {
      case .nickname:
        NameInputView(of: viewModel)
      case .gender:
        GenderInputView(of: viewModel)
      case .body:
        BodyInfoInputView(of: viewModel)
      }
    }
    .ignoresSafeArea(.keyboard)
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .navigationBarBackButtonHidden(true)
    .onAppear {
      UIApplication.shared.hideKeyboard()
      AppAnalytics.shared.log(.signUpStep(step: "user_info", stepNumber: 2))
    }
  }
}

private extension UserInfoInputView {
  func navgateBack() {
    switch viewModel.state.userInfoInputType {
    case .nickname:
      dismiss()
    case .gender:
      viewModel.navigate(action: .didTapUserInfoBackButton(viewModel.state.userInfoInputType))
    case .body:
      viewModel.state.selectedGender = .none
      viewModel.navigate(action: .didTapUserInfoBackButton(viewModel.state.userInfoInputType))
    }
  }
}
