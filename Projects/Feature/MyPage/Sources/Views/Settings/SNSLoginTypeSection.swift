//
//  SNSLoginTypeSection.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility

struct SNSLoginTypeSection: View {
  let type: SNSType
  
  var body: some View {
    HStack {
      Text("SNS 로그인")
        .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
        .foregroundStyle(Color(R.color.ff_F4F4F4))
      Spacer()
      
      switch type {
      case .kakao:
        Image(R.image.kakaoTypeIcon)
      case .apple:
        Image(R.image.appleTypeIcon)
      case .none:
        Image("")
      }
    }
  }
}
