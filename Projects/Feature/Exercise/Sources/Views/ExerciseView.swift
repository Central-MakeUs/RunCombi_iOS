//
//  ExerciseView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/8/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct ExerciseView: View {
  @StateObject private var viewModel = ExerciseViewModel()
  
  public init() {}
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      GoogleMapView(viewModel: viewModel)
      
      MapOverlayView(viewModel: viewModel)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)    
  }
}
