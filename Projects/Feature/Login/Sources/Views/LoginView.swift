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
import UserInterface

public struct LoginView: View {
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
            // TODO: - Kakao Login
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
          
          // 임시 버튼
          NavigationLink {
            ServiceAgreementView()
          } label: {
            Text("임시 버튼")
          }
        }
        .padding(.horizontal, 20)
      }
      .frame(maxWidth: .infinity)
      .background(Color(R.color.greyscale_01_171717))
    }
  }
}

#Preview {
  LoginView()
}
