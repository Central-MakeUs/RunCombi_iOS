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
  @State private var localityString = "위치 접근 미허용"
  
  public init() {}
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      GoogleMapView(localityString: $localityString)
      
      MapOverlayView(localityString: $localityString)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)    
  }
}
