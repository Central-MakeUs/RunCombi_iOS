//
//  ExerciseSettingView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility

public struct ExerciseSettingView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject private var viewModel: ExerciseViewModel
  
  public init(viewModel: ExerciseViewModel) {
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack {
        HStack {
          Button {
            dismiss()
          } label: {
            Image(R.image.backButton)
          }
          Spacer()
        }
        .padding(.top, 16)
        
        Text("오늘은, 초코와\n어떤 운동을 하실 건가요?")
          .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.top, 56)
        
        Spacer()
        Spacer()
        
        VStack(spacing: 16) {
          ForEach(WalkStyleType.allCases.reversed(), id: \.self) { type in
            if type != .none {
              Button {
                viewModel.send(action: .didTapWalkStyle(type))
              } label: {
                Text(type.exerciseSetting)
                  .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
                  .foregroundStyle(viewModel.state.selectedWalkStyle == type ? Color(R.color.greyscale_03_333333):  Color(R.color.greyscale_08_EDEDED))
                  .padding(EdgeInsets(top: 9, leading: 12, bottom: 9, trailing: 12))
                  .frame(maxWidth: .infinity)
                  .background(viewModel.state.selectedWalkStyle == type ? Color(R.color.primary_01_D7FE63):  Color(R.color.greyscale_04_525252))
                  .clipShape(.rect(cornerRadius: 6))
              }
            }
          }
        }
        
        Spacer()
      }
      .padding(.horizontal, 20)
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      viewModel.state.selectedWalkStyle = .none
    }
  }
}
