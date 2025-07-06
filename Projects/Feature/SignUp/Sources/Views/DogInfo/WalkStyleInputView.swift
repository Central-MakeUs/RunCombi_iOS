//
//  WalkStyleInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

struct WalkStyleInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    Text("산책 스타일")
  }
}
