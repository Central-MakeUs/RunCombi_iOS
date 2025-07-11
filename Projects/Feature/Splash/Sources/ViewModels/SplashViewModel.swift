//
//  SplashViewModel.swift
//  FeatureSplash
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

class SplashViewModel: ViewModelable {
  
  // MARK: - Actions
  
  enum Action {
    case splashDidFinish
  }
  
  // MARK: - States
  
  struct State {
    var isSplashPresented: Bool = true
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // MARK: - Initialize
  
  init() {}
  
  // MARK: - Action
  
  func send(action: Action) {
    switch action {
    case .splashDidFinish:
      checkAutoLogin()
    }
  }
}

private extension SplashViewModel {
  func checkAutoLogin() {
    if false {
      // TODO: - 자동 로그인
    } else {
      finishSplash()
    }
  }
  
  func finishSplash() {
    DispatchQueue.main.async { [weak self] in
      self?.state.isSplashPresented = false
    }
  }
}
