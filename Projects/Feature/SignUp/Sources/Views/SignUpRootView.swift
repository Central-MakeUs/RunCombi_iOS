//
//  SignUpRootView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/15/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import UserInterface

public struct SignUpRootView: View {
  @StateObject private var viewModel = SignUpViewModel()
  let isAgreementChecked: Bool
  
  public init(isAgreementChecked: Bool) {
    self.isAgreementChecked = isAgreementChecked
  }
  
  public var body: some View {
    NavigationStack {
      if isAgreementChecked {
        UserInfoInputView(viewModel: viewModel)
      } else {
        ServiceAgreementView(viewModel: viewModel)
      }
    }
    // 가입 플로우 전체에서 백스와이프 차단 (각 스텝의 커스텀 백버튼으로만 이동)
    .backSwipeDisabled()
  }
}
