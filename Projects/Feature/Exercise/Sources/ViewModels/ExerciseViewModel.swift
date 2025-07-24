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
    var selectedMemberWalkStyle = WalkStyleType.none
    var selectedDogWalkStyle = WalkStyleType.energetic
    var isExerciseViewPresented: Bool = false
    var isRootViewPresented: Bool = false
    var isCountDownViewPresented: Bool = false
    var isShowingHeader = true
    
    var exerciseStatus: ExerciseStatus = .ready
    var exerciseTime = 0
    var exerciseDistance = 0
    var exercisePersonKcal = 0
    var exerciseDogKcal = 0
    
    var isShowingSnackBar = false
    var isDisappearSnackBar = true
  }
  
  // MARK: - Properties
  
  @Published public var state = State()
  private var timer: Timer?
  private var startDate: Date? // 운동 시작 시간
  private var pauseDate: Date? // 일시정지 시점
  private var accumulatedTime: TimeInterval = 0 // 일시정지 전까지의 누적 운동 시간
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
      state.selectedMemberWalkStyle = type
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
    state.isShowingHeader = false
    state.isCountDownViewPresented = false
    
    startDate = Date()
    accumulatedTime = 0
    state.exerciseDistance = 0
    state.exerciseStatus = .exercise
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    startTimer()
  }

  func pauseExerciseTracking() {
    guard state.exerciseStatus == .exercise else { return }
    
    pauseDate = Date()
    if let start = startDate, let pause = pauseDate {
      accumulatedTime += pause.timeIntervalSince(start)
    }
    
    timer?.invalidate()
    timer = nil
    locationManager.stopUpdatingLocation()
    startDate = nil
    state.exerciseStatus = .pause
  }

  func resumeExerciseTracking() {
    guard state.exerciseStatus == .pause else { return }
    
    startDate = Date()
    state.exerciseStatus = .exercise
    
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    startTimer()
  }

  func stopExerciseTracking() {
    if let start = startDate {
      accumulatedTime += Date().timeIntervalSince(start)
    }
    timer?.invalidate()
    timer = nil
    locationManager.stopUpdatingLocation()
    state.exerciseStatus = .complete
    startDate = nil
  }
  
  func startTimer() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
      guard let self = self else { return }
      let elapsed = self.currentElapsedTime()
      self.state.exerciseTime = Int(elapsed)
      calculateKcal()
    }
  }

  func currentElapsedTime() -> TimeInterval {
    if let start = startDate {
      let total = accumulatedTime + Date().timeIntervalSince(start)
      return floor(total)
    } else {
      return floor(accumulatedTime)
    }
  }
  
  func calculateKcal() {
    calculatePersonKcal()
    calculateDogKcal()
  }
  
  func calculatePersonKcal() {
      let kg: Double = 70   // 몸무게도 Double
      let metValue = true ? state.selectedMemberWalkStyle.maleMET : state.selectedMemberWalkStyle.femaleMET
      let met: Double = Double(metValue)
      let hours: Double = Double(state.exerciseTime) / 3600.0
      let calories = kg * met * hours
  
      state.exercisePersonKcal = Int(calories)
  }

  func calculateDogKcal() {
      let kg: Double = 5.5
      let hours: Double = Double(state.exerciseTime) / 3600.0
      let factor: Double = Double(state.selectedDogWalkStyle.dogFactor)
      let calories = kg * 1.096 * factor * hours
      state.exerciseDogKcal = Int(calories)
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
