//
//  EditUserProfileView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct EditUserProfileView: View {
  var body: some View {
    VStack {
      EditHeader(title: "유저 정보 수정") {
        // TODO: - 유저 정보 수정
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
  }
}

#Preview {
  EditUserProfileView()
}
