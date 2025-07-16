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
  public func makeUIView(context: Context) -> GMSMapView {
    let camera = GMSCameraPosition(latitude: 47.0169, longitude: -122.336471, zoom: 3)
    let option = GMSMapViewOptions()
    option.camera = camera
    let mapView = GMSMapView(options: option)
    setMapStyle(of: mapView)
    return mapView
  }
  
  public func updateUIView(_ uiViewController: GMSMapView, context: Context) {
    
  }
}

// MARK: - GoogleMap Settings

private extension GoogleMapView {
  func setMapStyle(of mapView: GMSMapView) {
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
