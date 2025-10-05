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
import FeatureWatch
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
    var isSignUpViewPresented = false
    var isAgreementChecked = false
    var isMainViewPresented = false
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  @Published var memberDetail: MemberDetail?
  @Published var isSetMemberDetail: Bool = false
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
          Task { await self.login(to: oauthToken.accessToken, type: .kakao) }
        }
      }
    } else {
      UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
        if let error = error {
          // TODO: - Login Error 처리
          Logger.e("\(error)")
        }
        if let oauthToken = oauthToken{
          Task { await self.login(to: oauthToken.accessToken, type: .kakao) }
        }
      }
    }
  }
  
  func getAppleLoginInfo(_ result: Result<ASAuthorization, any Error>) async {
    switch result {
    case .success(let authResults):
      switch authResults.credential {
      case let appleIDCredential as ASAuthorizationAppleIDCredential:
        if let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8) {
          TokenManager.shared.setAppleUserID(to: appleIDCredential.user)
          Task { await login(to: authorizationCode, type: .apple) }
        } else {
          Logger.e("authorizationCode error")
        }
      default:
        break
      }
    case .failure(let error):
      Logger.e(error.localizedDescription)
    }
  }
  
  @MainActor
  func login(to token: String, type: SNSType) async {
    do {
      Logger.d(token)
      var result: LoginResult?
      if type == .kakao {
        result = try await loginClient.requestKakaoLoginToken(token: token)
      } else if type == .apple {
        result = try await loginClient.requestAppleLoginToken(token: token)
      }
      if let result {
        TokenManager.shared.handleLoginSuccess(accessToken: result.accessToken, refreshToken: result.refreshToken)
        UserDefaults.standard.set(type.rawValue, forKey: "loginType")
      }
      
      memberDetail = try await loginClient.getMemberDetail(token: TokenManager.shared.accessToken.ifNil(then: ""))
      isSetMemberDetail = true
      try handleMemberStatus((memberDetail?.memberStatus).ifNil(then: .unknown))
    } catch {
      Logger.e("\(error)")
      // TODO: - 로그인 실패 에러 처리
    }
  }
  
  private func handleMemberStatus(_ status: MemberStatus) throws {
    switch status {
    case .pendingAgree:
      state.isSignUpViewPresented = true
    case .pendingMemberDetail:
      state.isAgreementChecked = true
      state.isSignUpViewPresented = true
    case .live:
      state.isMainViewPresented = true
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      WatchSessionManager.shared.sendTokenToWatch(token)
    case .unknown:
      Logger.e("Unknown member status")
      throw ServerError.serverError
    }
  }
}
