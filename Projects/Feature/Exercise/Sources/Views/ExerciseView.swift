//
//  ExerciseView.swift
//  FeatureExercise
//
//  Created by Groonui on 7/23/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility
import UserInterface

public struct ExerciseView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var viewModel: ExerciseViewModel
  
  public init(viewModel: ExerciseViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      if viewModel.state.isCountDownViewPresented {
        CountDownView(viewModel: viewModel)
          .onDisappear {
            viewModel.send(action: .didDisappearCountDownView)
          }
      } else {
        VStack {
          HStack {
            Button {
              dismiss()
            } label: {
              Image(R.image.backButton)
            }
            Spacer()
            Button {
              viewModel.state.isRootViewPresented = true
            } label: {
              Image(systemName: "xmark")
                .frame(width: 24, height: 24)
            }
          }
          .padding(.top, 16)
          
          Spacer()
          
          VStack(spacing: 10) {
            Text("함께 운동한 시간")
              .giantsFont(size: 22, weight: .regular, lineHeight: 22)
              .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            
            VStack(spacing: 18) {
              Text(viewModel.state.exerciseTime.toTimeString())
                .giantsFont(size: 70, weight: .regular, lineHeight: 78)
                .foregroundStyle(Color(R.color.white_FFFFFF))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
              
              if viewModel.state.exerciseStatus != .ready {
                HStack(alignment: .bottom, spacing: 2) {
                  Text("3.02")
                    .giantsFont(size: 24, weight: .regular, lineHeight: 24)
                    .foregroundStyle(Color(R.color.greyscale_06_999999))
                    .modifier(CenteredShearEffect(angle: .degrees(-12)))
                  Text("km")
                    .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                    .foregroundStyle(Color(R.color.greyscale_06_999999))
                }
              } else {
                Text(" ")
                  .giantsFont(size: 24, weight: .regular, lineHeight: 24)
              }
            }
          }
          
          Spacer()
          Spacer()
          
          switch viewModel.state.exerciseStatus {
          case .ready:
            CTAButton(title: "시작", backgroundColor: Color(R.color.primary_01_D7FE63)) {
              viewModel.state.isCountDownViewPresented = true
            }
          case .exercise:
            CTAButton(image: Image(systemName: "pause.fill"), backgroundColor: Color(R.color.greyscale_02_252525)) {
              viewModel.send(action: .didTapPause)
              viewModel.state.exerciseStatus = .pause
            }
          case .pause:
            HStack(spacing: 48) {
              CTAButton(image: Image(systemName: "stop.fill"), backgroundColor: Color(R.color.ff_F4F4F4)) {
                
              } longPressAction: {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
                viewModel.send(action: .didEndExercise)
              }
              CTAButton(image: Image(systemName: "play.fill"), backgroundColor: Color(R.color.primary_01_D7FE63)) {
                viewModel.send(action: .didTapResume)
              }
            }
          case .complete:
            CTAButton(image: Image(systemName: "camera.fill"), backgroundColor: Color(R.color.primary_02_E8FFA3)) {
              // TODO: - 기록 페이지로 이동
            }
          }
          
          Spacer()
        }
        .padding(.horizontal, 20)
      }
    }
    .navigationBarBackButtonHidden()
  }
}
