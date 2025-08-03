//
//  EditHeader.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/19/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct EditHeader: View {
  @Environment(\.dismiss) var dismiss
  let title: String
  var isDisabled: Bool
  let cancelAction: (() -> Void)?
  let saveAction: () -> Void
  
  public init(title: String, isDisabled: Bool, cancelAction: (() -> Void)? = nil, saveAction: @escaping () -> Void) {
    self.title = title
    self.isDisabled = isDisabled
    self.cancelAction = cancelAction
    self.saveAction = saveAction
  }
  
  public var body: some View {
    HStack {
      Button {
        if let cancelAction {
          cancelAction()
        } else {
          dismiss()
        }
      } label: {
        Text("취소")
          .pretendardFont(size: 18, weight: .semiBold, lineHeight: 21)
          .foregroundStyle(Color(R.color.greyscale_05_757575))
      }
      
      Spacer()
      
      Text(title)
        .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
        .foregroundStyle(Color(R.color.white_FFFFFF))
      
      Spacer()
      
      Button {
        saveAction()
      } label: {
        Text("저장")
          .pretendardFont(size: 18, weight: .semiBold, lineHeight: 21)
          .foregroundStyle(isDisabled ? Color(R.color.primary_03_6C774C) : Color(R.color.primary_02_E8FFA3))
      }
      .disabled(isDisabled)
    }
    .padding(.vertical)
  }
}
