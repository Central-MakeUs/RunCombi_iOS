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

@main
struct RunCombiApp: App {
  
  init() {
    setFont()
    setKey()
    setToken()
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
    GMSServices.provideAPIKey("")
    KakaoSDK.initSDK(appKey: "")
  }
  
  private func setToken() {
    if !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
        TokenManager.shared.clearTokens()
        UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
    }
  }
}
