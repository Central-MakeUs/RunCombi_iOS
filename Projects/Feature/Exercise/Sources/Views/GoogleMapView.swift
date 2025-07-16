//
//  GoogleMapView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/16/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import GoogleMaps
import SharedUtility

struct GoogleMapView: UIViewRepresentable {
  private let mapView = GMSMapView()
  
  public func makeUIView(context: Context) -> GMSMapView {
    let camera = GMSCameraPosition(latitude: 37.5665, longitude: 126.9780, zoom: 6.5)
    mapView.camera = camera
    setMapStyle()
    return mapView
  }
  
  public func updateUIView(_ uiViewController: GMSMapView, context: Context) {
    
  }
}

// MARK: - GoogleMap Settings

private extension GoogleMapView {
  func setMapStyle() {
    do {
      if let styleURL = Bundle.main.url(forResource: "dark_style", withExtension: "json") {
        mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
      } else {
        Logger.e("Unable to find style.json")
      }
    } catch {
      Logger.e("One or more of the map styles failed to load. \(error)")
    }
  }
}
