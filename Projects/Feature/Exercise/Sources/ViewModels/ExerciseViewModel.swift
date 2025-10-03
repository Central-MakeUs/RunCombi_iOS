//
//  ExerciseViewModel.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import CoreLocation
import Foundation
import SwiftUI

import Dependencies
import DomainCalendar
import DomainExercise
import GoogleMaps
import ResourceKit
import SharedUtility

public class ExerciseViewModel: NSObject, ViewModelable, CLLocationManagerDelegate {
  
  // MARK: - Injections
  
  @Dependency(\.exerciseClient) var exerciseClient
  @Dependency(\.calendarClient) var calendarClient

  // MARK: - Actions
  
  public enum Action {
    case didTapWalkStyle(WalkStyleType)
    case didTapStart(Member)
    case didDisappearCountDownView
    case didTapPause
    case didTapResume
    case didEndExercise
    case didTapPhoto(Data)
  }
  
  // MARK: - States
  
  public struct State {
    var localityString = "위치 접근 미허용"
    var isMainLocationFetching: Bool = false
    var selectedMemberWalkStyle = WalkStyleType.none
    var isExerciseViewPresented: Bool = false
    var isRootViewPresented: Bool = false
    var isDetailViewPresented: Bool = false
    var isCountDownViewPresented: Bool = false
    var isShowingHeader = true
    
    var member: Member?
    var selectedPets: [Pet] = []
    var exerciseData: RunResult = RunResult.empty
    var exerciseStatus: ExerciseStatus = .ready
    var exerciseTime = 0
    var exerciseDistance = 0
    var exercisePersonKcal = 0
    var exercisePetsKcal: [Int] = [0, 0]
    var capturedPathImage: UIImage?
    
    var isShowingSnackBar = false
    var isDisappearSnackBar = true
    
    public var recordID: Int = -1
  }
  
  // MARK: - Properties
  
  @Published public var state = State()
  @Published public var isPermissionSheetPresented = false
  private var timer: Timer?
  private var startDate: Date? // 운동 시작 시간
  private var pauseDate: Date? // 일시정지 시점
  private var accumulatedTime: TimeInterval = 0 // 일시정지 전까지의 누적 운동 시간
  private let locationManager = CLLocationManager()
  private var lastLocation: CLLocation?
  
  @Published var path = GMSMutablePath()
  @Published var polyline = GMSPolyline()
  @Published var currentLocation: CLLocation?
  @Published public private(set) var pathBounds: GMSCoordinateBounds?
  @Published var snapshotContainer: UIView?

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
      navigateExerciseView(type: type)
    case .didTapStart(let member):
      Task { await startExercise(member: member) }
    case .didDisappearCountDownView:
      startExerciseTracking()
    case .didTapPause:
      pauseExerciseTracking()
    case .didTapResume:
      resumeExerciseTracking()
    case .didEndExercise:
      stopExerciseTracking()
    case .didTapPhoto(let photoData):
      setRunImage(to: photoData)
    }
  }
  
  func clear() {
    state.selectedMemberWalkStyle = WalkStyleType.none
    state.isExerciseViewPresented = false
    state.isCountDownViewPresented = false
    state.isShowingHeader = true
    
    state.member = nil
    state.selectedPets = []
    state.exerciseData = RunResult.empty
    state.exerciseStatus = .ready
    state.exerciseTime = 0
    state.exerciseDistance = 0
    state.exercisePersonKcal = 0
    state.exercisePetsKcal = [0, 0]
    state.capturedPathImage = nil
    
    timer = nil
    startDate = nil
    pauseDate = nil
    lastLocation = nil
    accumulatedTime = 0
    snapshotContainer = nil
    path.removeAllCoordinates()
  }
}

private extension ExerciseViewModel {
  func navigateExerciseView(type: WalkStyleType) {
    state.selectedMemberWalkStyle = type
    state.isExerciseViewPresented = true
    locationManager.requestAlwaysAuthorization()
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.pausesLocationUpdatesAutomatically = false
  }
  
  @MainActor
  func startExercise(member: Member) async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      state.member = member
      state.exerciseData = try await exerciseClient.startRun(
        token: token,
        petList: state.selectedPets.map { $0.petId },
        memberRunStyle: state.selectedMemberWalkStyle,
        isWatch: false
      )
      state.isCountDownViewPresented = true
    } catch {
      Logger.e("\(error)")
    }
  }
  
  @MainActor
  func updateRunData() async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      try await exerciseClient.midRunUpdate(token: token, requestModel: MemberRunData(
        runId: state.exerciseData.runId,
        runTime: state.exerciseTime / 60,
        runDistance: (Double(state.exerciseDistance.toKilometersString)).ifNil(then: 0)
      ), isWatch: false)
    } catch {
      Logger.e("\(error)")
    }
  }

  @MainActor
  func stopExercise() async {
    locationManager.allowsBackgroundLocationUpdates = false
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      try await exerciseClient.endRun(
        token: token,
        requestModel: EndRunRequestModel(
          memberRunData: MemberRunData(
            runId: state.exerciseData.runId,
            runTime: state.exerciseTime / 60,
            runDistance: (Double(state.exerciseDistance.toKilometersString)).ifNil(then: 0)
          ),
          petRunData: PetRunData(
            petCalList: state.selectedPets.map { PetCal(petId: $0.petId) }
          )
        ),
        routeImage: state.capturedPathImage?.pngData()
      )
    } catch {
      Logger.e("\(error)")
      // TODO: - 운동 종료 실패 처리
    }
  }
  
  func startExerciseTracking() {
    state.isShowingHeader = false
    state.isCountDownViewPresented = false
    
    startDate = Date()
    accumulatedTime = 0
    state.exerciseDistance = 0
    state.exerciseStatus = .exercise
    
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
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    
    startTimer()
  }
  
  func stopExerciseTracking() {
    if let start = startDate {
      accumulatedTime += Date().timeIntervalSince(start)
    }
    // TODO: - 지도에 현 위치 마커 찍기
    timer?.invalidate()
    timer = nil
    locationManager.stopUpdatingLocation()
    state.exerciseStatus = .complete
    startDate = nil
    
    if let view = snapshotContainer {
      SnapshotHelper.takeSnapshot(of: view) { [weak self] image in
        self?.state.capturedPathImage = image
      }
    }
    Task { await stopExercise() }
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
    for index in state.selectedPets.indices {
      let pet = state.selectedPets[index]
      state.exercisePetsKcal[index] = calculateDogKcal(for: pet)
    }
  }
  
  func calculatePersonKcal() {
    let kg: Double = Double(state.member?.weight ?? 60)
    let metValue = state.member?.gender == .male ? state.selectedMemberWalkStyle.maleMET : state.selectedMemberWalkStyle.femaleMET
    let met: Double = Double(metValue)
    let km: Double = Double(state.exerciseDistance) / 1000.0
    let calories = kg * met * km
    
    state.exercisePersonKcal = Int(calories)
  }
  
  func calculateDogKcal(for pet: Pet) -> Int {
    let kg: Double = pet.weight
    let km: Double = Double(state.exerciseDistance) / 1000.0
    let factor: Double = Double(pet.runStyle.dogFactor)
    let calories = kg * factor * km
    return Int(calories.rounded())
  }
}

public extension ExerciseViewModel {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let newLoc = locations.last else { return }
    Logger.d("\(newLoc.coordinate)")
    currentLocation = newLoc
    // 이전 위치가 있으면 거리 계산
    if let prev = lastLocation {
      let delta = newLoc.distance(from: prev)   // 미터 단위
      if delta < 10 { return } // 너무 미세한 움직임은 무시
      DispatchQueue.main.async {
        self.state.exerciseDistance += Int(delta)
      }
      
      Task { await updateRunData() }
      path.add(newLoc.coordinate)
      polyline.path = path
      polyline.strokeColor = UIColor(Color(R.color.primary_01_D7FE63))
      polyline.strokeWidth = 3
    }
    
    if path.count() > 1 {
      self.pathBounds = GMSCoordinateBounds(path: path)
    }
    
    lastLocation = newLoc
  }
}

extension ExerciseViewModel {
  private func setRunImage(to data: Data) {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.setRunImage(token: token, runID: state.exerciseData.runId, runImage: data)
        navigateToRecord()
      } catch {
        Logger.e("\(error)")
      }
    }
  }
  
  func navigateToRecord() {
    DispatchQueue.main.async {
      self.state.recordID = self.state.exerciseData.runId
      self.state.isDetailViewPresented = true
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.clear()        
      }
    }
  }
}
