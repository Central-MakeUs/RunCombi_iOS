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
      } else {
        VStack {
          if viewModel.state.isShowingHeader {
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
                Image(R.image.xmark)
              }
            }
            .padding(.top, 16)
          }
          
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
                  Text(viewModel.state.exerciseDistance.toKilometersString)
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
          
          ExerciseKcalSection(viewModel: viewModel)
          
          Spacer()
          
          switch viewModel.state.exerciseStatus {
          case .ready:
            CTAButton(title: "시작", backgroundColor: Color(R.color.primary_01_D7FE63)) {
              viewModel.state.isCountDownViewPresented = true
            }
          case .exercise:
            CTAButton(image: Image(R.image.pause), backgroundColor: Color(R.color.greyscale_02_252525)) {
              viewModel.send(action: .didTapPause)
            }
          case .pause:
            HStack(spacing: 48) {
              CTAButton(image: Image(R.image.stop), backgroundColor: Color(R.color.ff_F4F4F4)) {
                if viewModel.state.isShowingSnackBar == false && viewModel.state.isDisappearSnackBar {
                  viewModel.state.isShowingSnackBar = true
                  viewModel.state.isDisappearSnackBar = false
                }
              } longPressAction: {
                viewModel.send(action: .didEndExercise)
              }
              CTAButton(image: Image(R.image.play), backgroundColor: Color(R.color.primary_01_D7FE63)) {
                viewModel.send(action: .didTapResume)
              }
            }
            .padding(.horizontal)
          case .complete:
            CTAButton(image: Image(R.image.camera), backgroundColor: Color(R.color.primary_02_E8FFA3)) {
              // TODO: - 기록 페이지로 이동
            }
          }
          
          Spacer()
        }
        .padding(.horizontal, 20)
      }
    }
    .navigationBarBackButtonHidden()
    .overlay(
      Group {
        if viewModel.state.isShowingSnackBar {
          HStack {
            Text("버튼을 길게 눌러야 운동이 종료돼요!")
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            Spacer()
            Button {
              withAnimation {
                viewModel.state.isShowingSnackBar = false
              }
            } label: {
              Image(R.image.xmark)
                .renderingMode(.template)
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            }
          }
          .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 8))
          .transition(.move(edge: .top).combined(with: .opacity))
          .task {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
              withAnimation {
                viewModel.state.isShowingSnackBar = false
              }
            }
          }
          .onDisappear {
            viewModel.state.isDisappearSnackBar = true
          }
        }
      }
        .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)), alignment: .top
    )
  }
}
