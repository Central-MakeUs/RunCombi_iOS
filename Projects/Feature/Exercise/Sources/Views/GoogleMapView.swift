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
  @ObservedObject var viewModel: ExerciseViewModel
  private let locationManager = CLLocationManager()
  private let mapView = GMSMapView()
  
  @State private var lastLocation: CLLocation?
  
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
    guard let location = locations.last else { return }
    
    let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
    parent.mapView.animate(to: camera)
    Logger.d("Location: \(location)")
    
    if let last = parent.lastLocation, location.distance(from: last) < 100 {
      // 100m 이내 이동이면 무시
      return
    }
    parent.lastLocation = location
    if let lastLocation = parent.lastLocation {
      let geocoder = CLGeocoder()
      geocoder.reverseGeocodeLocation(lastLocation) { [weak self] placemarks, error in
        if let error = error {
          Logger.e("Reverse geocoding failed: \(error.localizedDescription)")
          return
        }
        
        if let placemark = placemarks?.first {
          let country = placemark.country ?? ""
          let administrativeArea = placemark.administrativeArea ?? ""
          let locality = placemark.locality ?? ""
          let subLocality = placemark.subLocality ?? ""
          let name = placemark.name ?? ""
          Logger.d("📍 위치 정보: \(country) \(administrativeArea) \(locality) \(subLocality) \(name)")
          self?.parent.viewModel.state.localityString = "\(locality) \(subLocality)"
        }
      }
    }
  }
}
