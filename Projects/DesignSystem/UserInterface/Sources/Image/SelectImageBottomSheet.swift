//
//  SelectImageBottomSheet.swift
//  UserInterface
//
//  Created by 임경빈 on 8/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct SelectImageBottomSheet: View {
  @Binding private var isPresented: Bool
  @Binding private var isCameraPresented: Bool
  @Binding private var isPhotosPickerPresented: Bool
  
  public init(
    isPresented: Binding<Bool>,
    isCameraPresented: Binding<Bool>,
    isPhotosPickerPresented: Binding<Bool>
  ) {
    self._isPresented = isPresented
    self._isCameraPresented = isCameraPresented
    self._isPhotosPickerPresented = isPhotosPickerPresented
  }
  
  public var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        HStack {
          Text("카메라 또는 앨범을 선택해 주세요")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
            .foregroundColor(Color(R.color.white_FFFFFF))
          
          Spacer()
          
          Button {
            isPresented = false
          } label: {
            Image(R.image.xmark)
              .renderingMode(.template)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
          }
        }
      }
      
      HStack(spacing: 10) {
        Button {
          isPresented = false
          isCameraPresented = true
        } label :{
          PrimaryActionLabel(
            text: "카메라",
            height: 48,
            backgroundColor: Color(R.color.primary_01_D7FE63)
          )
        }
        
        Button {
          isPresented = false
          isPhotosPickerPresented = true
        } label :{
          PrimaryActionLabel(
            text: "앨범",
            height: 48,
            backgroundColor: Color(R.color.primary_01_D7FE63)
          )
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
}
