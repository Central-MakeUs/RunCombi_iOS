//
//  SignUpRootView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/15/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

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
  }
}
