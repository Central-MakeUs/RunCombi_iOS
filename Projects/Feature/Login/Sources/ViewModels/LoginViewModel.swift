//
//  LoginViewModel.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import AuthenticationServices
import Foundation

import CoreNetwork
import Dependencies
import DomainLogin
import KakaoSDKAuth
import KakaoSDKUser
import SharedUtility

class LoginViewModel: ViewModelable {
  
  // MARK: - Injections
  
  @Dependency(\.loginClient) var loginClient
  
  // MARK: - Actions
  
  enum Action {
    case tappedKakaoLogin
    case tappedAppleLogin(ASAuthorizationAppleIDRequest)
    case completedAppleLogin(Result<ASAuthorization, any Error>)
  }
  
  // MARK: - States
  
  struct State {
    var isSignupViewPresented = false
    var isMainViewPresented = false
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // MARK: - Initialize
  
  init() {
    
  }
  
  
  // MARK: - Action
  
  func send(action: Action) {
    switch action {
    case .tappedKakaoLogin:
      getKakaoLoginInfo()
    case .tappedAppleLogin(let request):
      request.requestedScopes = [.fullName, .email]
    case .completedAppleLogin(let result):
      Task { await getAppleLoginInfo(result) }
    }
  }
}

private extension LoginViewModel {
  func getKakaoLoginInfo() {
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          // TODO: - Login Error 처리
          Logger.e("\(error)")
        }
        if let oauthToken = oauthToken {
          Task { await self.login(to: oauthToken.accessToken) }
        }
      }
    } else {
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let error = error {
          // TODO: - Login Error 처리
          Logger.e("\(error)")
        }
        if let oauthToken = oauthToken{
          Task { await self.login(to: oauthToken.accessToken) }
        }
      }
    }
  }
  
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
  
  @MainActor
  func login(to token: String) async {
    do {
      let result = try await loginClient.requestKakaoLoginToken(token: token)
      TokenManager.shared.handleLoginSuccess(accessToken: result.accessToken, refreshToken: result.refreshToken)
      if result.finishRegister == "Y" {
        state.isMainViewPresented = true
      } else {
        state.isSignupViewPresented = true
      }
    } catch {
      Logger.e("\(error)")
    }
  }
}
