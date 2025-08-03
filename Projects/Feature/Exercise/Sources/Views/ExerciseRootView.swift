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
    .onChange(of: viewModel.state.isRootViewPresented) {
      if viewModel.state.isRootViewPresented {
        currentTab = .calendar
        path.removeLast(path.count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          path.append("RecordDetailView")
        }
      }
      viewModel.state.isRootViewPresented = false
    }
    .onChange(of: viewModel.state.isExerciseViewPresented) {
      if viewModel.state.isExerciseViewPresented {
        path.append("ExerciseView")
      }
      viewModel.state.isExerciseViewPresented = false
    }
  }
}
