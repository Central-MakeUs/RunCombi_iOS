//
//  ExerciseView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/8/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import GoogleMaps

public struct ExerciseView: View {
  
  public init() {}
  
  public var body: some View {
    GMSMapViewRepresentable()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(.red)
  }
}

#Preview {
  ExerciseView()
}

struct GMSMapViewRepresentable: UIViewRepresentable {
  
  public func makeUIView(context: Context) -> GMSMapView {
    let camera = GMSCameraPosition(latitude: 47.0169, longitude: -122.336471, zoom: 3)
    let mapID = GMSMapID(identifier: "")
    let option = GMSMapViewOptions()
    option.mapID = mapID
    option.camera = camera
    return GMSMapView(options: option)
  }
  
  public func updateUIView(_ uiViewController: GMSMapView, context: Context) {
    
  }
}
