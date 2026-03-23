//
//  LogoutSheet.swift
//  FeatureMyPage
//
//  Created by Groonui on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import KakaoSDKUser
import ResourceKit
import SharedUtility
import UserInterface

struct LogoutSheet: View {
  @EnvironmentObject private var userManager: UserManager
  @Environment(\.dismiss) var dismiss
  @Binding var isPresented: Bool
  
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        Text("정말 로그아웃 하실 거예요...?")
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("콤비가 기다릴지도 몰라요!\n쉬고 싶다면, 살짝 쉬었다가 다시 만나요.")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      HStack(spacing: 10) {
        Button {
          handleLogout()
        } label: {
          PrimaryActionLabel(
            text: "로그아웃",
            foregroundColor: Color(R.color.greyscale_02_252525),
            backgroundColor: Color(R.color.greyscale_08_EDEDED)
          )
        }
        
        Button {
          isPresented = false
        } label: {
          PrimaryActionLabel(
            text: "아니요",
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
}

private extension LogoutSheet {
  func handleLogout() {
    let loginType = SNSType.convertSNSType(UserDefaults.standard.string(forKey: "loginType").ifNil(then: ""))
    if loginType == .kakao {
      kakaoLogout()
    } else {
      logout()
      Logger.d("✅ 애플 로그아웃 성공")
    }
  }
  
  func kakaoLogout() {
    UserApi.shared.logout { error in
      if let error = error {
        Logger.e("⚠️ 카카오 로그아웃 실패: \(error)")
      } else {
        Logger.d("✅ 카카오 로그아웃 성공")
      }
      logout()
    }
  }
  
  func logout() {
    TokenManager.shared.clearTokens()
    UserDefaults.standard.removeObject(forKey: "loginType")
    userManager.clearUserManager()
  }
}
