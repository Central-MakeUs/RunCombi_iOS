//
//  SurveyRow.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct SurveyRow: View {
  let type: SurveyType
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Text(type.text)
          .pretendardFont(size: 16, weight: .medium, lineHeight: 20)
          .foregroundStyle(Color(R.color.white_FFFFFF))
        Spacer()
        if isSelected {
          Image(R.image.checkBox)
        } else {
          Image(R.image.unCheckBox)
        }
      }
    }
  }
}
