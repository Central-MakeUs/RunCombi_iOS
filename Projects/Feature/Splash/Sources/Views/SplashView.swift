//
//  SplashView.swift
//  FeatureSplash
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import AuthenticationServices
import SwiftUI

import Dependencies
import DomainLogin
import DomainMyPage
import ResourceKit
import SharedUtility
import UserInterface

public struct SplashView: View {
  
  // MARK: - Injections
  
  @Dependency(\.loginClient) var loginClient
  @Dependency(\.myPageClient) var myPageClient
  
  @EnvironmentObject var userManager: UserManager
  @Binding private var isSplashPresented: Bool
  @State private var isUpdateAlertPresented = false
  @State private var isUpdateButtonPresented = false
  
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
    .overlay(alignment: .bottom) {
      if isUpdateButtonPresented {
        Button {
          openAppStore(urlStr: "itms-apps://itunes.apple.com/app/apple-store/6747975586")
        } label: {
          PrimaryActionLabel(text: "앱 업데이트", backgroundColor: Color(R.color.primary_01_D7FE63))
            .padding(.horizontal, 20)
        }
      }
    }
    .task {
      if await checkVersionUpdate() {
        isUpdateAlertPresented = true
      } else {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          checkAutoLogin()
        }
      }
    }
    .alert("업데이트 안내", isPresented: $isUpdateAlertPresented, actions: {
      Button {
        isUpdateButtonPresented = true
        openAppStore(urlStr: "itms-apps://itunes.apple.com/app/apple-store/6747975586")
      } label: {
        Text("업데이트")
      }
    }, message: {
      Text("더 나은 서비스를 위하여\n최신 버전으로 업데이트해주세요.")
    })
  }
  
  private func checkVersionUpdate() async -> Bool {
    do {
      let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
      return try await myPageClient.checkVersion(version: appVersion)
    } catch {
      Logger.e("\(error)")
      return false
    }
  }
  
  private func openAppStore(urlStr: String) {
    guard let url = URL(string: urlStr) else {
      isSplashPresented = false
      return
    }
    
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      isSplashPresented = false
    }
  }
  
  func checkAutoLogin() {
    Logger.d(TokenManager.shared.accessToken.ifNil(then: ""))
    let loginType = SNSType.convertSNSType(UserDefaults.standard.string(forKey: "loginType").ifNil(then: ""))
    if loginType == .apple, let userID = TokenManager.shared.appleUserID {
      let provider = ASAuthorizationAppleIDProvider()
      provider.getCredentialState(forUserID: userID) { (credentialState, error) in
        switch credentialState {
        case .authorized, .transferred:
          autoLogin()
        case .notFound, .revoked:
          isSplashPresented = false
        @unknown default:
          isSplashPresented = false
        }
      }
    } else {
      autoLogin()
    }
  }
  
  @MainActor
  func autoLogin() {
    Task{
      do {
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
}
