//
//  SignUpCompletedView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Lottie
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
        if let url = R.file.congratulationsJson() {
          LottieView(animation: .filepath(url.path))
            .looping()
            .frame(maxWidth: .infinity)
        }
        
        VStack(spacing: 68.5) {
          Spacer()
          
          Text("\(viewModel.state.typpedNickname) 님,\n가입을 축하합니다!")
            .pretendardFont(size: 28, weight: .semiBold, lineHeight: 40)
            .foregroundColor(Color(R.color.white_FFFFFF))
            .multilineTextAlignment(.center)
          
          Image(R.image.completedDog)
          
          Text("이제 \(viewModel.state.typpedDogName)\(isLetterWithBase(text: viewModel.state.typpedDogName) ? "과" : "와") 함께\n건강한 일상을 채워나가 볼까요?")
            .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
            .foregroundColor(Color(R.color.white_FFFFFF))
            .multilineTextAlignment(.center)
          
          Spacer()
        }
      }
      
      Button {
        viewModel.state.isMoreDogSheetPresented = true
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
    .bottomSheet(isPresented: $viewModel.state.isMoreDogSheetPresented) {
      CheckMoreDogSheet(of: viewModel)
    }
  }
  
  func isLetterWithBase(text: String) -> Bool {
    // 1) 빈 문자열 → 받침 없음
    guard let lastChar = text.last else {
        return false
    }
    // 2) Character의 첫 유니코드 스칼라값 가져오기
    guard let scalar = lastChar.unicodeScalars.first else {
        return false
    }
    let value = scalar.value
    // 3) 한글 완성형 음절 블록(0xAC00…0xD7A3)인지 확인
    guard (0xAC00...0xD7A3).contains(value) else {
        return false
    }
    // 4) 음절 인덱스 계산 후 28로 나눈 나머지가 0이면 받침 없음
    let syllableIndex = value - 0xAC00
    let jong = syllableIndex % 28
    return jong != 0
  }
}
