//
//  ExerciseRootView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/8/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility

public struct ExerciseRootView: View {
  @ObservedObject private var viewModel: ExerciseViewModel
  @Binding var path: NavigationPath
  @Binding var currentTab: MainTab
  
  public init(path: Binding<NavigationPath>, currentTab: Binding<MainTab>, viewModel: ExerciseViewModel) {
    self._path = path
    self._currentTab = currentTab
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      GoogleMapView(viewModel: viewModel)
        .onAppear {
          viewModel.state.isMainLocationFetching = true
        }
        .onDisappear {
          viewModel.state.isMainLocationFetching = false
        }
      
      MapOverlayView(viewModel: viewModel, path: $path)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .trackScreen("exercise_home")
    .onChange(of: viewModel.state.isRootViewPresented) {
      if viewModel.state.isRootViewPresented {
        path.removeLast(path.count)
      }
      viewModel.state.isRootViewPresented = false
    }
    .onChange(of: viewModel.state.isExerciseViewPresented) {
      if viewModel.state.isExerciseViewPresented {
        path.append("ExerciseView")
      }
      viewModel.state.isExerciseViewPresented = false
    }
    .onChange(of: viewModel.state.isDetailViewPresented) {
      if viewModel.state.isDetailViewPresented {
        currentTab = .calendar
        // 종료된 운동 화면이 스택에 남지 않도록 비운 뒤 기록 상세로 이동 (백스와이프 시 홈으로 복귀)
        path.removeLast(path.count)
        path.append("RecordDetailView")
      }
      viewModel.state.isDetailViewPresented = false
    }
  }
}
