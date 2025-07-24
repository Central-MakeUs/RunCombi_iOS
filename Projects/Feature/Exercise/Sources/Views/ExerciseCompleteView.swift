//
//  ExerciseCompleteView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Lottie
import ResourceKit
import UserInterface

struct ExerciseCompleteView: View {
  @ObservedObject var viewModel: ExerciseViewModel
  
  var body: some View {
    VStack(spacing: 24) {
      HStack {
        Spacer()
        Button {
          viewModel.state.isRootViewPresented = true
          // TODO: - 기록 페이지로 이동
        } label: {
          Image(R.image.xmark)
            .renderingMode(.template)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        }
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      
      VStack(spacing: 8) {
        Text("첫 운동 찟었다")
          .giantsFont(size: 32, weight: .regular, lineHeight: 32)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
        Text("사진을 찍어 추억을 남겨보세요")
          .giantsFont(size: 16, weight: .regular, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED).opacity(0.88))
      }
      
      Rectangle()
        .fill(.green)
        .overlay {
          if let url = R.file.congratulationsJson() {
            LottieView(animation: .filepath(url.path))
              .looping()
              .frame(maxWidth: .infinity)
          }
        }
      
      VStack(spacing: 50) {
        HStack(spacing: 48) {
          VStack {
            Text("운동 시간")
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
            HStack(alignment: .bottom, spacing: .zero) {
              Text("120")
                .giantsFont(size: 24, weight: .regular, lineHeight: 24)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
              Text(" min")
                .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
            }
          }
          
          VStack {
            Text("운동 거리")
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
            HStack(alignment: .bottom, spacing: .zero) {
              Text("5.05")
                .giantsFont(size: 24, weight: .regular, lineHeight: 24)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
              Text(" km")
                .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
            }
          }
        }
        
        CTAButton(image: Image(R.image.camera), backgroundColor: Color(R.color.primary_02_E8FFA3)) {
          // TODO: - 기록 페이지로 이동
        }
        .padding(.bottom)
      }
    }
  }
}
