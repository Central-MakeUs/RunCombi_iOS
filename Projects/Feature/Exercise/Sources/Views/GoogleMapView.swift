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
  
  var isPathMap = false
  
  public func makeUIView(context: Context) -> GMSMapView {
    setDefaultCamera()
    setMapStyle()
    if isPathMap {
      mapView.isMyLocationEnabled = true
      viewModel.polyline.map = mapView
    } else {
      setGesture()
      context.coordinator.attach(to: mapView)
    }
    return mapView
  }
  
  public func updateUIView(_ uiViewController: GMSMapView, context: Context) {
    if isPathMap {
      if let bounds = viewModel.pathBounds {
        // 경로 전체가 화면에 들어오도록 카메라 업데이트 생성
        let fitUpdate = GMSCameraUpdate.fit(bounds, withPadding: 50)
        uiViewController.animate(with: fitUpdate)
      }
    } else {
      if viewModel.state.isMainLocationFetching {
        context.coordinator.startUpdating()
      } else {
        context.coordinator.stopUpdating()
      }
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}

// MARK: - GoogleMap Settings

private extension GoogleMapView {
  func setDefaultCamera() {
    let camera = GMSCameraPosition(latitude: 37.5665, longitude: 126.9780, zoom: isPathMap ? 15 : 6.5)
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
      let resource = false ? "path_style" : "dark_style"
      if let styleURL = Bundle.main.url(forResource: resource, withExtension: "json") {
        mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
      } else {
        Logger.e("Unable to find style.json")
      }
    } catch {
      Logger.e("One or more of the map styles failed to load. \(error)")
    }
  }
}

extension GoogleMapView {
  final class Coordinator: NSObject {
    let parent: GoogleMapView
    private let locationManager = CLLocationManager()
    
    init(_ parent: GoogleMapView) {
      self.parent = parent
      super.init()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.distanceFilter = 10
    }
    
    func attach(to mapView: GMSMapView) {
      mapView.isMyLocationEnabled = true
    }
    
    func startUpdating() {
      locationManager.requestWhenInUseAuthorization()
      locationManager.startUpdatingLocation()
    }
    
    func stopUpdating() {
      locationManager.stopUpdatingLocation()
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
