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
    
  }
  
  // MARK: - States
  
  struct State {
    var localityString = "위치 접근 미허용"
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // MARK: - Initialize
  
  init() {
    
  }
  
  
  // MARK: - Action
  
  func send(action: Action) {
  }
}
