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
  @ObservedObject var viewModel: SignUpViewModel
  
  var body: some View {
    VStack(spacing: 34) {
      UserInfoInputHeader(inputType: .nickname)
        .padding(.top, 34)
      
      switch viewModel.state.userInfoInputType {
      case .nickname:
        NicknameInputView()
      case .gender:
        GenderInputView()
      case .body:
        BodyInfoInputView()
      }
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .navigationBarBackButtonHidden(true)
  }
}
