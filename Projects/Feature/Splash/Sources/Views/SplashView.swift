//
//  SplashView.swift
//  FeatureSplash
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainLogin
import ResourceKit
import SharedUtility

public struct SplashView: View {
  
  // MARK: - Injections
  
  @Dependency(\.loginClient) var loginClient
  
  @EnvironmentObject var userManager: UserManager
  @Binding private var isSplashPresented: Bool
  
  public init(isSplashPresented: Binding<Bool>) {
    self._isSplashPresented = isSplashPresented
  }
  
  public var body: some View {
    VStack {
      Spacer()
      
      Image(R.image.logo)
      
      Spacer()
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .task {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        Task { await checkAutoLogin() }
      }
    }
  }
  
  @MainActor
  func checkAutoLogin() async {
    do {
      Logger.d(TokenManager.shared.accessToken.ifNil(then: ""))
      let memberDetail = try await loginClient.getMemberDetail(token: TokenManager.shared.accessToken.ifNil(then: ""))
      userManager.setUserManager(to: memberDetail)
      switch memberDetail.memberStatus {
      case .live:
        /// 메인 화면으로
        userManager.isAgreementChecked = true
        userManager.isLoggedIn = true
      case .pendingAgree:
        /// 서비스 동의 화면으로
        userManager.isSigning = true
      case .pendingMemberDetail:
        /// 정보 입력 화면으로
        userManager.isSigning = true
        userManager.isAgreementChecked = true
      case .unknown:
        /// 로그인 화면으로
        break
      }
      isSplashPresented = false
    } catch {
      Logger.e("\(error)")
      /// 로그인 화면으로
      isSplashPresented = false
    }
  }
}
