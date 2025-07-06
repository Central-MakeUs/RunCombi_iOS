//
//  ServiceAgreementRow.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct ServiceAgreementRow: View {
  let type: AgreementType
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    Button {
      action()
    } label: {
      HStack {
        Text(String(key: type.stringKey))
          .pretendardFont(size: 16, weight: .medium, lineHeight: 20)
          .foregroundStyle(Color(R.color.white_FFFFFF))
        Spacer()
        if isSelected {
          Image(R.image.checkBox)
        } else {
          Rectangle()
            .fill(Color(R.color.gray_292929))
            .frame(width: 20, height: 20)
            .clipShape(.rect(cornerRadius: 2))
        }
      }
    }
  }
}
