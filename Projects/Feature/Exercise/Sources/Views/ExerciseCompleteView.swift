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
          viewModel.clear()
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
        let isFirstRun = viewModel.state.exerciseData.isFirstRun
        Text(isFirstRun ? "첫 운동 찢었다" : "이번 달 \(viewModel.state.exerciseData.runCountOfMonth)번째 운동")
          .giantsFont(size: 32, weight: .regular, lineHeight: 32)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
        Text(isFirstRun ? "사진을 찍어 추억을 남겨보세요" : "앞으로도 계속 함께 할 거죠?")
          .giantsFont(size: 16, weight: .regular, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED).opacity(0.88))
      }
      
      GoogleMapView(viewModel: viewModel, isPathMap: true)
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
              Text("\(viewModel.state.exerciseTime / 60)")
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
              Text(viewModel.state.exerciseDistance.toKilometersString)
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
  }
}
