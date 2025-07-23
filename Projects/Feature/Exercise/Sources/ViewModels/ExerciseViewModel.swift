//
//  ExerciseViewModel.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

public class ExerciseViewModel: ViewModelable {
  
  // MARK: - Actions
  
  public enum Action {
    case didTapWalkStyle(WalkStyleType)
    case didDisappearCountDownView
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
  
  // MARK: - Initialize
  
  public init() {
    
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
    }
  }
}

private extension ExerciseViewModel {
  func startExerciseTracking() {
    state.exerciseTime = 0
    state.exerciseDistance = 0
    
    DispatchQueue.main.async {
      self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
        guard let self = self else { return }
        self.state.exerciseTime += 1
      }
    }
  }
}
