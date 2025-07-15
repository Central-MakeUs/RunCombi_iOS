//
//  WalkStyleInputView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct WalkStyleInputView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 49) {
      VStack(spacing: 9) {
        Text("산책스타일을 알려주세요")
          .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("더 정확한 반려견 소모 칼로리 계산을 위해 필요해요")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      VStack(spacing: 5) {
        Text("산책스타일")
          .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        VStack(spacing: 14) {
          ForEach(WalkStyleType.allCases, id: \.self) { type in
            if type != .none {
              Button {
                viewModel.send(action: .didTapWalkStyle(type))
              } label: {
                Text(type.rawValue)
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(viewModel.state.selectedWalkStyle == type ? Color(R.color.greyscale_03_333333):  Color(R.color.greyscale_08_EDEDED))
                  .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .background(viewModel.state.selectedWalkStyle == type ? Color(R.color.primary_01_D7FE63):  Color(R.color.greyscale_04_525252))
                  .clipShape(.rect(cornerRadius: 6))
              }
            }
          }
        }
      }
      
      Spacer()
      
      Button {
        viewModel.send(action: .didTapComplete)
      } label: {
        PrimaryActionLabel(
          text: "완료",
          backgroundColor: viewModel.state.selectedWalkStyle == .none ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
        )
      }
      .disabled(viewModel.state.selectedWalkStyle == .none)
    }
    .navigationDestination(isPresented: $viewModel.state.isSignUpCompleted) {
      SignUpCompletedView(of: viewModel)
    }
  }
}
