//
//  SplashViewModel.swift
//  FeatureSplash
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Dependencies
import DomainLogin
import SharedUtility

class SplashViewModel: ViewModelable {
  
  // MARK: - Injections
  
  @Dependency(\.loginClient) var loginClient
  
  // MARK: - Actions
  
  enum Action {
    case splashDidFinish
  }
  
  // MARK: - States
  
  struct State {
    var isSplashPresented: Bool = true
    var isLoggedIn: Bool = false
    var isSigning: Bool = false
    var isAgreementChecked: Bool = false
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // MARK: - Initialize
  
  init() {}
  
  // MARK: - Action
  
  func send(action: Action) {
    switch action {
    case .splashDidFinish:
      Task { await checkAutoLogin() }
    }
  }
}

private extension SplashViewModel {
  @MainActor
  func checkAutoLogin() async {
    do {
      let memberDetail = try await loginClient.getMemberDetail(token: TokenManager.shared.accessToken.ifNil(then: ""))
      Logger.d("\(memberDetail)")
      switch memberDetail.memberStatus {
      case .live:
        /// 메인 화면으로
        state.isAgreementChecked = true
        state.isLoggedIn = true
      case .pendingAgree:
        /// 서비스 동의 화면으로
        state.isSigning = true
      case .pendingMemberDetail:
        /// 정보 입력 화면으로
        state.isSigning = true
        state.isAgreementChecked = true
      case .unknown:
        /// 로그인 화면으로
        break
      }
      state.isSplashPresented = false
    } catch {
      Logger.e("\(error)")
      /// 로그인 화면으로
      state.isSplashPresented = false
    }
  }
}
