//
//  EditCombiButton.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct EditCombiButton: View {
  let action: () -> Void
  
  var body: some View {
    VStack(spacing: 8) {
      Image(R.image.defaultDog)
      VStack(spacing: .zero) {
        Text("초코")
          .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
        Text("말티푸")
          .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
          .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
      }
    }
    .frame(maxWidth: .infinity)
    .aspectRatio(1, contentMode: .fit)
    .padding(EdgeInsets(top: 26, leading: 0, bottom: 12, trailing: 0))
    .background(Color(R.color.greyscale_02_252525).opacity(0.3))
    .clipShape(.rect(cornerRadius: 6))
    .overlay(alignment: .topTrailing) {
      Button {
        action()
      } label: {
        Image(R.image.pencil)
      }
      .padding(8)
    }
  }
}
