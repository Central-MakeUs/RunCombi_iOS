//
//  SettingView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility
import UserInterface

struct SettingView: View {
  @Environment(\.dismiss) var dismiss
  @State private var isWebViewPresented = false
  @State private var selectedWebViewURL = ""
  
  var body: some View {
    VStack(spacing: 16) {
      ZStack {
        HStack {
          Button {
            dismiss()
          } label: {
            Image(R.image.backButton)
          }
          Spacer()
        }
        
        HStack {
          Spacer()
          Text("설정")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
            .foregroundStyle(Color(R.color.white_FFFFFF))
          Spacer()
        }
      }
      .padding(.top, 16)
      
      VStack(spacing: 40) {
        VStack(alignment: .leading, spacing: 16) {
          Text("약관 및 정책")
            .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
          
          VStack(spacing: 20) {
            SettingItem(title: "서비스 이용약관") {
              navigateTermsView(type: .serviceTerms)
            }
            SettingItem(title: "개인정보 처리방침") {
              navigateTermsView(type: .personalPrivacy)
            }
            SettingItem(title: "위치정보 이용약관") {
              navigateTermsView(type: .locationTerms)
            }
          }
        }
        
        VStack(alignment: .leading, spacing: 16) {
          Text("계정")
            .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
          
          VStack(spacing: 20) {
            SettingItem(title: "SNS 로그인") {
              
            }
            SettingItem(title: "로그아웃") {
              
            }
            SettingItem(title: "회원 탈퇴") {
              
            }
          }
        }
        
        VStack(alignment: .leading, spacing: 16) {
          Text("고객")
            .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
          
          SettingItem(title: "런콤비 개선 제안") {
            
          }
        }
      }
      .padding(.top, 20)
      .frame(maxWidth: .infinity)
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
    .navigationDestination(isPresented: $isWebViewPresented) {
      NotionWebView(url: selectedWebViewURL)
    }
  }
  
  private struct SettingItem: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
      Button {
        action()
      } label: {
        HStack {
          Text(title)
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.ff_F4F4F4))
          Spacer()
          Image(R.image.pushButton)
        }
      }
    }
  }
}

private extension SettingView {
  func navigateTermsView(type: TermsType) {
    selectedWebViewURL = type.urlString
    isWebViewPresented = true
  }
}
