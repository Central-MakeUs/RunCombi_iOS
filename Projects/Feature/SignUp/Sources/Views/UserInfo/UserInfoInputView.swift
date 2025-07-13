//
//  UserInfoInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct UserInfoInputView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel: SignUpViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      InfoInputHeader(title: "사용자 정보", progress: viewModel.state.userInfoInputType.rawValue) {
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
  }
}

private extension UserInfoInputView {
  func navgateBack() {
    if viewModel.state.userInfoInputType == .nickname {
      dismiss()
    } else {
      viewModel.navigate(action: .didTapUserInfoBackButton(viewModel.state.userInfoInputType))
    }
  }
}
