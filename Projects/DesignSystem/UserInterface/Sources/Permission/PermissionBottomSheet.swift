//
//  PermissionBottomSheet.swift
//  UserInterface
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility

public struct PermissionBottomSheet: View {
  private let type: PermissionType
  @Binding private var isPresented: Bool
  
  public init(type: PermissionType, isPresented: Binding<Bool>) {
    self.type = type
    self._isPresented = isPresented
  }
  
  public var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        Text(type.title)
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundColor(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        Text(type.description)
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundColor(Color(R.color.gray_C0C0C0))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      HStack(spacing: 10) {
        Button {
          isPresented = false
        } label :{
          PrimaryActionLabel(
            text: "취소",
            height: 48,
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }
        
        Button {
          isPresented = false
          PermissionManager.shared.openAppSettings()
        } label :{
          PrimaryActionLabel(
            text: "설정으로 이동",
            height: 48,
            backgroundColor: Color(R.color.primary_01_D7FE63)
          )
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
}
