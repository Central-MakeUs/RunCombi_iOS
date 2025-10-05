//
//  ExerciseManager.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 9/20/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import CoreLocation
import Foundation

import CoreNetwork
import Dependencies
import DomainExercise
import SharedUtility

final class ExerciseManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Dependency(\.exerciseClient) var exerciseClient
  
  private var timer: Timer?
  private var startDate: Date?
  
  @Published var isTokenAlertPresented = false
  @Published var isRunning = false
  @Published var isStyleSetting = false
  @Published var isCombiSelecting = false
  
  @Published var elapsedTime: TimeInterval = 0
  @Published var distance: Int = 0
  @Published var exerciseData: RunResult = RunResult.empty
  @Published var selectedMemberRunStyle: WalkStyleType = .none
  @Published var selectedPets: [Pet] = []
  
  private let locationManager = CLLocationManager()
  private var lastLocation: CLLocation?
  
  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.activityType = .fitness
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = 10
  }
  
  func checkToken() {
    if WatchSessionManagerInWatch.shared.token == nil {
      isTokenAlertPresented = true
    } else {
      isCombiSelecting = true
    }
  }
  
  func start() {
    guard let token = WatchSessionManagerInWatch.shared.token else {
      Logger.e("⚠️ 토큰이 없습니다. iPhone에서 전달되지 않음.")
      return
    }
    
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
    
    // 포그라운드일 때 위치 추적 권한 요청
    locationManager.requestWhenInUseAuthorization()
    
    // 위치 업데이트
    locationManager.startUpdatingLocation()
    
    // 위치 추적 시작
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    Logger.d("권한 상태: \(locationPermissionStatus())")
    Task {
      await startExercise(token: token)
    }
  }
  
  public enum LocationPermissionStatus {
    case authorized, denied, notDetermined, restricted
  }
  
  public func locationPermissionStatus() -> LocationPermissionStatus {
    switch locationManager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      return .authorized
    case .denied:
      return .denied
    case .restricted:
      return .restricted
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
      return .notDetermined
    @unknown default:
      return .denied
    }
  }
  
  func stop() {
    isRunning = false
    isStyleSetting = false
    timer?.invalidate()
    timer = nil
    selectedPets = []
    selectedMemberRunStyle = .none
    locationManager.stopUpdatingLocation()
    Task { await updateRunData() }
  }
  
  @MainActor
  func startExercise(token: String) async {
    do {
      Logger.d(token)
      exerciseData = try await exerciseClient.startRun(
        token: token,
        petList: selectedPets.map({ $0.petId }),
        memberRunStyle: selectedMemberRunStyle,
        isWatch: true
      )
    } catch {
      Logger.e("\(error)")
    }
  }
  
  @MainActor
  func updateRunData() async {
    do {
      try await exerciseClient.midRunUpdate(
        token: WatchSessionManagerInWatch.shared.token.ifNil(then: ""),
        requestModel: MemberRunData(
          runId: exerciseData.runId,
          runTime: Int(elapsedTime) / 60,
          runDistance: (Double(distance.toKilometersString)).ifNil(then: 0)
        ),
        isWatch: true
      )
    } catch {
      Logger.e("\(error)")
    }
  }
  
  var elapsedTimeString: String {
    Int(elapsedTime).toTimeString()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let newLoc = locations.last else { return }
    Logger.d("\(newLoc)")
    // 이전 위치가 있으면 거리 계산
    if let prev = lastLocation {
      let delta = newLoc.distance(from: prev)   // 미터 단위
      if delta < 10 { return } // 너무 미세한 움직임은 무시
      DispatchQueue.main.async {
        self.distance += Int(delta)
      }
      Task { await updateRunData() }
    }
    lastLocation = newLoc
  }
}
