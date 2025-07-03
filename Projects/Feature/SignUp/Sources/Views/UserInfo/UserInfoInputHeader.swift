//
//  UserInfoInputHeader.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct UserInfoInputHeader: View {
  let inputType: UserInfoInputType
  let backButtonAction: () -> Void
  
  var body: some View {
    VStack(spacing: 11) {
      ZStack {
        HStack {
          Button {
            backButtonAction()
          } label: {
            Image(R.image.backButton)
          }
          Spacer()
        }
        
        HStack {
          Spacer()
          Text("사용자 정보")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 40)
            .foregroundStyle(Color(R.color.white_FFFFFF))
          Spacer()
        }
      }
      
      ProgressBar.create(
        value: inputType.rawValue,
        height: 4,
        foregroundColor: Color(R.color.primary_01_D7FE63),
        backgroundColor: Color(R.color.gray_121F23),
        radius: 3
      )
    }
  }
}
