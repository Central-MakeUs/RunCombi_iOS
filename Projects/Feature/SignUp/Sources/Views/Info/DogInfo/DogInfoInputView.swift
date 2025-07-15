//
//  DogInfoInputView.swift
//  FeatureSignUp
//
//  Created by Groonui on 7/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct DogInfoInputView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel: SignUpViewModel
  
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 0) {
      InfoInputHeader(title: "반려견 정보", progress: viewModel.state.dogInfoInputType.rawValue, isBackButtonPresented: true) {
        navgateBack()
      }
      .padding(.vertical, 34)
      
      switch viewModel.state.dogInfoInputType {
      case .name:
        DogNameInputView(of: viewModel)
      case .body:
        DogBodyInfoInputView(of: viewModel)
      case .walkStyle:
        WalkStyleInputView(of: viewModel)
      }
    }
    .ignoresSafeArea(.keyboard)
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .navigationBarBackButtonHidden(true)
    .onAppear {
      UIApplication.shared.hideKeyboard()
    }
  }
}

private extension DogInfoInputView {
  func navgateBack() {
    if viewModel.state.dogInfoInputType == .name {
      dismiss()
    } else {
      viewModel.navigate(action: .didTapDogInfoBackButton(viewModel.state.dogInfoInputType))
    }
  }
}
