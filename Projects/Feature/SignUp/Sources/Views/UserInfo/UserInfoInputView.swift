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
    VStack(spacing: 0) {
      UserInfoInputHeader(inputType: viewModel.state.userInfoInputType)
        .padding(.top, 34)
      
      switch viewModel.state.userInfoInputType {
      case .nickname:
        NameInputView(of: viewModel)
          .padding(.top, 29)
      case .gender:
        GenderInputView()
          .padding(.top, 34)
      case .body:
        BodyInfoInputView()
          .padding(.top, 34)
      }
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .navigationBarBackButtonHidden(true)
  }
}
