//
//  LoginView.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import AuthenticationServices
import SwiftUI

import FeatureSignUp
import LocalizableStringManager
import ResourceKit
import SharedUtility
import UserInterface

public struct LoginView: View {
  @EnvironmentObject var userManager: UserManager
  @ObservedObject var viewModel = LoginViewModel()
  
  public init() {}
  
  public var body: some View {
    ZStack {
      VStack {
        Spacer()
        
        Image(R.image.logo)
        
        Spacer()
        Spacer()
      }
      
      VStack(spacing: 14) {
        Spacer()
        
        KakaoLoginButton() {
          viewModel.send(action: .tappedKakaoLogin)
        }
        
        AppleLoginButton()
          .overlay {
            SignInWithAppleButton(
              onRequest: { request in
                viewModel.send(action: .tappedAppleLogin(request))
              },
              onCompletion: { result in
                viewModel.send(action: .completedAppleLogin(result))
              }
            )
            .blendMode(.overlay)
          }
      }
      .padding(20)
    }
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .onChange(of: viewModel.isSetMemberDetail) {
      if let detail = viewModel.memberDetail {
        userManager.setUserManager(to: detail)
      }
    }
    .onChange(of: viewModel.state.isMainViewPresented) {
      userManager.isLoggedIn = true
    }
    .onChange(of: viewModel.state.isSignUpViewPresented) {
      userManager.isSigning = true
      userManager.isAgreementChecked = viewModel.state.isAgreementChecked
    }
    .overlay(
      Group {
        if userManager.isDeleteAccountSnackBarPresented {
          HStack {
            Image(R.image.checkBox)
            Text("콤비와의 여정 종료, 언제든 다시 만나요!")
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            Spacer()
          }
          .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 8))
          .transition(.move(edge: .top).combined(with: .opacity))
          .task {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
              withAnimation {
                userManager.isDeleteAccountSnackBarPresented = false
              }
            }
          }
        }
      }
      .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)), alignment: .top
    )
  }
}

#Preview {
  LoginView()
}
