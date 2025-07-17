//
//  AddCombiButton.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct AddCombiButton: View {
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      VStack(spacing: 8) {
        Image(R.image.emptyDog)
        VStack(spacing: 6) {
          Image(R.image.plus)
          Text("콤비 추가")
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
        }
      }
      .frame(maxWidth: .infinity)
      .aspectRatio(1, contentMode: .fit)
      .padding(EdgeInsets(top: 26, leading: 0, bottom: 12, trailing: 0))
      .background {
        RoundedRectangle(cornerRadius: 6)
          .fill(.clear)
          .stroke(Color(R.color.greyscale_03_333333), lineWidth: 1)
      }
    }
  }
}
