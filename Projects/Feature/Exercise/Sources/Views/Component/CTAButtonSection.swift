//
//  CTAButtonSection.swift
//  FeatureExercise
//
//  Created by Groonui on 7/24/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct CTAButtonSection: View {
  @ObservedObject var viewModel: ExerciseViewModel
  @Namespace private var ctaNamespace
  
  var body: some View {
    Group {
      switch viewModel.state.exerciseStatus {
      case .ready:
        CTAButton(title: "시작", backgroundColor: Color(R.color.primary_01_D7FE63)) {
          viewModel.send(action: .didTapStart)
        }
      case .exercise:
        CTAButton(image: Image(R.image.pause), backgroundColor: Color(R.color.greyscale_02_252525)) {
          viewModel.send(action: .didTapPause)
        }
        .matchedGeometryEffect(id: "ctaButton", in: ctaNamespace)
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
          .matchedGeometryEffect(id: "ctaButton", in: ctaNamespace)
          
          CTAButton(image: Image(R.image.play), backgroundColor: Color(R.color.primary_01_D7FE63)) {
            viewModel.send(action: .didTapResume)
          }
        }
        .padding(.horizontal)
      case .complete:
        EmptyView()
      }
    }
    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.state.exerciseStatus)
  }
}
