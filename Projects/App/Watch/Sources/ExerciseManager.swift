//
//  ExerciseManager.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 9/20/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import CoreLocation
import Foundation

final class ExerciseManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  private var timer: Timer?
  private var startDate: Date?
  
  @Published var elapsedTime: TimeInterval = 0
  @Published var distance: Double = 0
  @Published var isRunning = false
  
  private let locationManager = CLLocationManager()
  private var lastLocation: CLLocation?
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.activityType = .fitness
    locationManager.allowsBackgroundLocationUpdates = true
  }
  
  func start() {
    isRunning = true
    startDate = Date()
    elapsedTime = 0
    distance = 0
    lastLocation = nil
    
    // 타이머 시작
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
      if let startDate = self.startDate {
        self.elapsedTime = Date().timeIntervalSince(startDate)
      }
    }
    
    // 위치 추적 시작
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
  }
  
  func stop() {
    isRunning = false
    timer?.invalidate()
    timer = nil
    locationManager.stopUpdatingLocation()
  }
  
  var elapsedTimeString: String {
    let minutes = Int(elapsedTime) / 60
    let seconds = Int(elapsedTime) % 60
    return String(format: "%02d:%02d", minutes, seconds)
  }
  
  // CLLocationManagerDelegate
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard isRunning else { return }
    for location in locations {
      if let last = lastLocation {
        distance += location.distance(from: last)
      }
      lastLocation = location
    }
  }
}
