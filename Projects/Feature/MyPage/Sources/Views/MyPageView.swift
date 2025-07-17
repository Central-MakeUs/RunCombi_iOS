//
//  MyPageView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

public struct MyPageView: View {
  
  public init() {}
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 16) {
        HStack {
          Spacer()
          Button {
            
          } label: {
            Image(R.image.setting)
          }
        }
        .padding(.top, 16)
        
        VStack(spacing: 19) {
          Image(R.image.person)
          
          VStack(spacing: 12) {
            Text("닉네임")
              .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            
            Button {
              /// 내 정보 수정 화면으로 이동
              
            } label: {
              Text("내 정보 수정")
                .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                .foregroundStyle(Color(R.color.greyscale_05_757575))
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                .background {
                  RoundedRectangle(cornerRadius: 6)
                    .fill(.clear)
                    .stroke(Color(R.color.greyscale_05_757575), lineWidth: 0.6)
                }
            }
          }
        }
        .padding(.top, 32)
        
        HStack(spacing: 12) {
          EditCombiButton() {
            /// 콤비 수정 화면으로 이동
          }
          AddCombiButton() {
            /// 콤비 추가 화면으로 이동
          }
        }
        .padding(.top, 40)
        
        Spacer()
      }
      .padding(.horizontal, 20)
    }
  }
}
