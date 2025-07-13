//
//  AppleLoginButton.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct AppleLoginButton: View {
  var body: some View {
    Button {
      
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
            .tracking(-0.1)
          Spacer()
        }
      }
      .frame(height: 48)
      .background(Color(R.color.white_FFFFFF))
      .clipShape(.rect(cornerRadius: 6))
    }
  }
}
