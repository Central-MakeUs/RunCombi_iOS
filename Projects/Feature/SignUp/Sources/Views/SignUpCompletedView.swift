//
//  SignUpCompletedView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct SignUpCompletedView: View {
  @ObservedObject var viewModel: SignUpViewModel
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: .zero) {
      ZStack {
        GIFImage(path: R.file.congratulationsGif())
          .frame(maxWidth: .infinity)
        
        VStack(spacing: 68.5) {
          Spacer()
          
          Text("\(viewModel.state.typpedNickname) 님,\n가입을 축하합니다!")
            .pretendardFont(size: 28, weight: .semiBold, lineHeight: 40)
            .foregroundColor(Color(R.color.white_FFFFFF))
            .multilineTextAlignment(.center)
          
          Image(R.image.logo)
          
          Text("이제 \(viewModel.state.typpedDogName)와 함께\n건강한 일상을 채워나가 볼까요?")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundColor(Color(R.color.white_FFFFFF))
            .multilineTextAlignment(.center)
          
          Spacer()
        }
      }
      
      Button {
        // TODO: - 런닝탭 스크린으로 이동
      } label: {
        PrimaryActionLabel(
          text: "좋아요",
          backgroundColor: Color(R.color.primary_01_D7FE63)
        )
      }
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background {
      LinearGradient(
        colors: [
          Color(R.color.green_1F2805),
          Color(R.color.black_000000)
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea()
    }
    .navigationBarBackButtonHidden()
  }
}
