//
//  MapOverlayView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/17/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import ResourceKit
import SharedUtility
import UserInterface

struct MapOverlayView: View {
  @EnvironmentObject var userManager: UserManager
  @ObservedObject var viewModel: ExerciseViewModel
  @Binding var path: NavigationPath
  
  var body: some View {
    VStack {
      VStack(spacing: 47) {
        HStack(spacing: 10) {
          Image(R.image.location)
          Text(viewModel.state.localityString)
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        }
        .padding(.top, 15)
        
        VStack(spacing: 25) {
          Text("함께 운동할 콤비 선택")
            .giantsFont(size: 18, weight: .regular, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          
          SelectDogView(selectedPets: $viewModel.state.selectedPets)
        }
      }
      
      Spacer()
      
      Button {
        PermissionManager.shared.requestLocationPermission { granted in
          if granted {
            if viewModel.state.selectedPets.isEmpty {
              if viewModel.state.isDisappearSnackBar {
                withAnimation {
                  viewModel.state.isDisappearSnackBar = false
                  viewModel.state.isShowingSnackBar = true
                }
              }
            } else {
              path.append("ExerciseSettingView")
            }
          } else {
            viewModel.isPermissionSheetPresented = true
          }
        }
      } label: {
        Text("운동")
          .giantsFont(size: 24, weight: .regular, lineHeight: 28)
          .foregroundStyle(Color(R.color.greyscale_02_252525))
          .frame(width: 100, height: 100)
          .background(Color(R.color.primary_01_D7FE63))
          .clipShape(.rect(cornerRadius: 4))
      }
      .padding(.bottom, 50)
    }
    .frame(maxWidth: .infinity)
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(R.color.greyscale_01_171717).opacity(0.99),
          Color(R.color.black_000000).opacity(0),
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .frame(height: 350)
      , alignment: .top
    )
    .overlay(
      Group {
        if viewModel.state.isShowingSnackBar {
          HStack {
            Text("함께 운동할 콤비를 선택해주세요!")
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
