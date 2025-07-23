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
          
          Text("00:00")
            .giantsFont(size: 70, weight: .regular, lineHeight: 78)
            .italic()
            .foregroundStyle(Color(R.color.white_FFFFFF))
        }
        
        Spacer()
        Spacer()
        
        Button {
          
        } label: {
          Text("시작")
            .giantsFont(size: 24, weight: .regular, lineHeight: 28)
            .foregroundStyle(Color(R.color.greyscale_02_252525))
            .frame(width: 100, height: 100)
            .background(Color(R.color.primary_01_D7FE63))
            .clipShape(.rect(cornerRadius: 4))
        }
        
        Spacer()
      }
      .padding(.horizontal, 20)
    }
    .navigationBarBackButtonHidden()
  }
}
