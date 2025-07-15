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
    NavigationStack {
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
      .navigationDestination(isPresented: $viewModel.state.isSignUpViewPresented) {
        SignUpRootView(isAgreementChecked: viewModel.state.isAgreementChecked)
      }
    }
    .onChange(of: viewModel.state.isMainViewPresented) {
      // TODO: - UserData 넣기
      userManager.isLoggedIn = true
    }
  }
}

#Preview {
  LoginView()
}
