//
//  AppVersionSection.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct AppVersionSection: View {
  let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

  var body: some View {
    HStack {
      HStack(alignment: .bottom, spacing: 8) {
        Text("앱 버전")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.ff_F4F4F4))
        
        Text("v.\(appVersion)")
          .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
      }
      Spacer()
      
      Button {
        // TODO: - 업데이트 기능 추가
      } label: {
        Text("업데이트")
          .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
          .foregroundStyle(Color(R.color.black_000000))
          .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
          .background(Color(R.color.greyscale_03_333333))
          .clipShape(.rect(cornerRadius: 2))
      }
    }
  }
}

#Preview {
  AppVersionSection()
}
