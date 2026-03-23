//
//  RunCombiApp.swift
//  RunCombi
//
//  Created by 임경빈 on 6/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import GoogleMaps
import KakaoSDKAuth
import KakaoSDKCommon
import SharedUtility
import UserInterface
import FeatureWatch

@main
struct RunCombiApp: App {
  
  init() {
    setFont()
    setKey()
    setToken()
    WatchSessionManager.shared.activateSession()
  }
  
  var body: some Scene {
    WindowGroup {
      AppView()
        .onOpenURL { url in
          if (AuthApi.isKakaoTalkLoginUrl(url)) {
            _ = AuthController.handleOpenUrl(url: url)
          }
        }
    }
  }
  
  private func setFont() {
    FontKit.registerPretendardFonts()
    FontKit.registerGiantsFonts()
  }
  
  private func setKey() {
    let googleKey = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_MAPS_API_KEY") as? String ?? ""
    let kakaoKey = Bundle.main.object(forInfoDictionaryKey: "KAKAO_APP_KEY") as? String ?? ""
    GMSServices.provideAPIKey(googleKey)
    KakaoSDK.initSDK(appKey: kakaoKey)
  }
  
  private func setToken() {
    if !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
        TokenManager.shared.clearTokens()
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
  }
}
