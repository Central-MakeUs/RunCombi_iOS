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
  private let locationManager = CLLocationManager()
  private let mapView = GMSMapView()
  
  public func makeUIView(context: Context) -> GMSMapView {
    setDefaultCamera()
    setGesture()
    setMapStyle()
    setLocationManager(context)
    return mapView
  }
  
  public func updateUIView(_ uiViewController: GMSMapView, context: Context) {
    
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}

// MARK: - GoogleMap Settings

private extension GoogleMapView {
  func setDefaultCamera() {
    let camera = GMSCameraPosition(latitude: 37.5665, longitude: 126.9780, zoom: 6.5)
    mapView.camera = camera
  }
  
  func setGesture() {
    mapView.settings.scrollGestures = false
    mapView.settings.zoomGestures = false
    mapView.settings.rotateGestures = false
    mapView.settings.tiltGestures = false
  }
  
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
  
  func setLocationManager(_ context: Context) {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    locationManager.delegate = context.coordinator
    mapView.isMyLocationEnabled = true
  }
}

extension GoogleMapView {
  final class Coordinator: NSObject {
    let parent: GoogleMapView
    
    init(_ parent: GoogleMapView) {
      self.parent = parent
    }
  }
}

extension GoogleMapView.Coordinator: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location: CLLocation = locations.last!
    Logger.d("Location: \(location)")
    
    let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
    
    parent.mapView.animate(to: camera)
  }
}
