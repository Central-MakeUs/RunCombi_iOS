//
//  LoginViewModel.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import AuthenticationServices
import Foundation

import SharedUtility

class LoginViewModel: ViewModelable {
  
  // MARK: - Actions
  
  enum Action {
    case tappedAppleLogin(ASAuthorizationAppleIDRequest)
    case completedAppleLogin(Result<ASAuthorization, any Error>)
  }
  
  // MARK: - States
  
  struct State {
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // MARK: - Initialize
  
  init() {
    
  }
 
  
  // MARK: - Action
  
  func send(action: Action) {
    switch action {
    case .tappedAppleLogin(let request):
      request.requestedScopes = [.fullName, .email]
    case .completedAppleLogin(let result):
      Task { await getAppleLoginInfo(result) }
    }
  }
}

private extension LoginViewModel {
  func getAppleLoginInfo(_ result: Result<ASAuthorization, any Error>) async {
    switch result {
    case .success(let authResults):
      switch authResults.credential {
      case let appleIDCredential as ASAuthorizationAppleIDCredential:
        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
        Logger.d("\(authResults)")
        Logger.d(authorizationCode ?? "")
      default:
        break
      }
    case .failure(let error):
      Logger.e(error.localizedDescription)
    }
  }
}
