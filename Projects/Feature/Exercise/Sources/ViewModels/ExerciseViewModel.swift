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
  }
  
  // MARK: - States
  
  public struct State {
    var localityString = "위치 접근 미허용"
    var selectedWalkStyle = WalkStyleType.none
    var isExerciseViewPresented: Bool = false
    var isRootViewPresented: Bool = false
  }
  
  // MARK: - Properties
  
  @Published public var state = State()
  
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
    }
  }
}
