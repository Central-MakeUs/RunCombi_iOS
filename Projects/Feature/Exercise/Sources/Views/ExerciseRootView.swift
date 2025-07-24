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
  
  public init(path: Binding<NavigationPath>, viewModel: ExerciseViewModel) {
    self._path = path
    self.viewModel = viewModel
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      GoogleMapView(viewModel: viewModel)
      
      MapOverlayView(viewModel: viewModel)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
  }
}
