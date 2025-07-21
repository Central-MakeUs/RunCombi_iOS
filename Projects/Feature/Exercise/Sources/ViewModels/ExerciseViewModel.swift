//
//  ExerciseViewModel.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

class ExerciseViewModel: ViewModelable {
  
  // MARK: - Actions
  
  enum Action {
    case didTapWalkStyle(WalkStyleType)
  }
  
  // MARK: - States
  
  struct State {
    var localityString = "위치 접근 미허용"
    var selectedWalkStyle = WalkStyleType.none
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // MARK: - Initialize
  
  init() {
    
  }
  
  // MARK: - Action
  
  func send(action: Action) {
    switch action {
    case .didTapWalkStyle(let type):
      state.selectedWalkStyle = type
    }
  }
}
