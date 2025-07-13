//
//  KakaoLoginButton.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct KakaoLoginButton: View {
  let kakaoLoginAction: () -> Void
  
  var body: some View {
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
          .tracking(-0.1)
        Spacer()
      }
    }
    .frame(height: 48)
    .background(Color(R.color.yellow_FEE102))
    .clipShape(.rect(cornerRadius: 6))
    .onTapGesture {
      kakaoLoginAction()
    }
  }
}
