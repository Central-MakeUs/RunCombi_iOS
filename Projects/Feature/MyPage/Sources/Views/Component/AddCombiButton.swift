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
  @Binding var snackBarItem: String
  
  var body: some View {
    NavigationLink {
      /// 콤비 추가 화면으로 이동
      AddCombiProfileView(snackBarItem: $snackBarItem)
    } label: {
      VStack(spacing: 12) {
        Image(R.image.emptyDog)
        Image(R.image.plus)
      }
      .padding(EdgeInsets(top: 35, leading: 0, bottom: 19, trailing: 0))
      .frame(maxWidth: 154, maxHeight: 154, alignment: .top)
      .background {
        RoundedRectangle(cornerRadius: 6)
          .fill(.clear)
          .stroke(Color(R.color.greyscale_03_333333), lineWidth: 1)
      }
    }
  }
}
