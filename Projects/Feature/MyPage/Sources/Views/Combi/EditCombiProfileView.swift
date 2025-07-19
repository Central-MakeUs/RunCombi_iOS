//
//  EditCombiProfileView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct EditCombiProfileView: View {
  var body: some View {
    VStack {
      EditHeader(title: "콤비 정보 수정") {
        // TODO: - 콤비 정보 수정
      }
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
  }
}

#Preview {
  EditCombiProfileView()
}
