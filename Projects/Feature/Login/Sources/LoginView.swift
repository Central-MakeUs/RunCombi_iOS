//
//  LoginView.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import FeatureSignUp
import LocalizableStringManager
import ResourceKit
import UserInterface

public struct LoginView: View {
  
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
          
          Button {
            // TODO: = 카카오 Login
          } label: {
            ZStack {
              HStack {
                Image(R.image.symbolKakao)
                Spacer()
              }
              .padding(.leading, 23)
              
              HStack {
                Spacer()
                Text("카카오로 시작하기")
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 25)
                  .foregroundStyle(Color(R.color.black_000000))
                Spacer()
              }
            }
            .frame(height: 48)
            .background(Color(R.color.yellow_FEE102))
            .clipShape(.rect(cornerRadius: 6))
          }
          
          Button {
            // TODO: = Apple Login
          } label: {
            ZStack {
              HStack {
                Image(R.image.symbolApple)
                Spacer()
              }
              .padding(.leading, 23)
              
              HStack {
                Spacer()
                Text("Apple로 시작하기")
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 25)
                  .foregroundStyle(Color(R.color.black_000000))
                Spacer()
              }
            }
            .frame(height: 48)
            .background(Color(R.color.white_FFFFFF))
            .clipShape(.rect(cornerRadius: 6))
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
