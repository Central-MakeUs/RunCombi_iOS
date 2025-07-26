//
//  CheckMoreDogSheet.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface
import SharedUtility

struct CheckMoreDogSheet: View {
  @EnvironmentObject var userManager: UserManager
  @ObservedObject var viewModel: SignUpViewModel
  
  init(of viewModel: SignUpViewModel) {
    self.viewModel = viewModel
  }
  
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        Text("혹시 콤비가 더 있나요?")
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundColor(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        Text("런콤비는 최대 2마리의 반려견과 함께할 수 있어요.\n지금 바로 반려견을 추가해볼까요?")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundColor(Color(R.color.gray_C0C0C0))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      HStack(spacing: 10) {
        Button {
          userManager.isLoggedIn = true
        } label :{
          PrimaryActionLabel(
            text: "괜찮아요",
            height: 48,
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }
        
        Button {
          userManager.isLoggedIn = true
        } label :{
          PrimaryActionLabel(
            text: "추가",
            height: 48,
            backgroundColor: Color(R.color.primary_01_D7FE63)
          )
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
}
