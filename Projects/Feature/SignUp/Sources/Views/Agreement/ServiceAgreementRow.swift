//
//  ServiceAgreementRow.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility
import UserInterface

struct ServiceAgreementRow: View {
  let type: TermsType
  let isSelected: Bool
  let action: () -> Void
  
  var body: some View {
    HStack {
      NavigationLink {
        NotionWebView(url: type.urlString)
      } label: {
        Text(String(key: type.stringKey))
          .pretendardFont(size: 16, weight: .medium, lineHeight: 20)
          .foregroundStyle(Color(R.color.white_FFFFFF))
      }
      Spacer()
      Button {
        action()
      } label: {
        if isSelected {
          Image(R.image.checkBox)
        } else {
          Image(R.image.unCheckBox)
        }
      }
    }
  }
}
