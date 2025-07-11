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
import UserInterface

@main
struct RunCombiApp: App {
  
  init() {
    FontKit.registerPretendardFonts()
    GMSServices.provideAPIKey("")
    KakaoSDK.initSDK(appKey: "")
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
}
