//
//  ExerciseViewModel.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import CoreLocation
import Foundation

import SharedUtility

public class ExerciseViewModel: NSObject, ViewModelable, CLLocationManagerDelegate {
  
  // MARK: - Actions
  
  public enum Action {
    case didTapWalkStyle(WalkStyleType)
    case didDisappearCountDownView
    case didTapPause
    case didTapResume
    case didEndExercise
  }
  
  // MARK: - States
  
  public struct State {
    var localityString = "위치 접근 미허용"
    var selectedWalkStyle = WalkStyleType.none
    var isExerciseViewPresented: Bool = false
    var isRootViewPresented: Bool = false
    var isCountDownViewPresented: Bool = false
    
    var exerciseStatus: ExerciseStatus = .ready
    var exerciseTime = 0
    var exerciseDistance = 0
  }
  
  // MARK: - Properties
  
  @Published public var state = State()
  private var timer: Timer?
  private let locationManager = CLLocationManager()
  private var lastLocation: CLLocation?
  
  
  // MARK: - Initialize
  
  public override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 10
  }
  
  // MARK: - Action
  
  public func send(action: Action) {
    switch action {
    case .didTapWalkStyle(let type):
      state.selectedWalkStyle = type
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
        self?.state.isExerciseViewPresented = true
      }
    case .didDisappearCountDownView:
      startExerciseTracking()
    case .didTapPause:
      pauseExerciseTracking()
    case .didTapResume:
      resumeExerciseTracking()
    case .didEndExercise:
      stopExerciseTracking()
    }
  }
}

private extension ExerciseViewModel {
  func startExerciseTracking() {
    state.exerciseTime = 0
    state.exerciseDistance = 0
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      if self.state.exerciseStatus == .exercise {
        self.state.exerciseTime += 1
      }
    }
  }
  
  func pauseExerciseTracking() {
    guard state.exerciseStatus == .exercise else { return }
    timer?.invalidate()
    timer = nil
    locationManager.stopUpdatingLocation()
    lastLocation = nil
    state.exerciseStatus = .pause
  }
  
  func resumeExerciseTracking() {
    guard state.exerciseStatus == .pause else { return }
    state.exerciseStatus = .exercise
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      if self.state.exerciseStatus == .exercise {
        self.state.exerciseTime += 1
      }
    }
  }
  
  func stopExerciseTracking() {
    timer?.invalidate()
    timer = nil
    locationManager.stopUpdatingLocation()
    state.exerciseStatus = .complete
  }
}

public extension ExerciseViewModel {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let newLoc = locations.last else { return }
    // 이전 위치가 있으면 거리 계산
    if let prev = lastLocation {
      let delta = newLoc.distance(from: prev)   // 미터 단위
      DispatchQueue.main.async {
        self.state.exerciseDistance += Int(delta)
      }
    }
    lastLocation = newLoc
  }
}
