//
//  EditCombiButton.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import ResourceKit
import UserInterface
import SharedUtility

struct EditCombiButton: View {
  @EnvironmentObject var userManager: UserManager
  let combiID: Int
  let action: () -> Void
  
  var body: some View {
    VStack(spacing: 12) {
      if let imageURLString = userManager.petList.first(where: { $0.petId == combiID })?.petImageUrl,
         let imageURL = URL(string: imageURLString) {
        KFImage(imageURL)
          .resizable()
          .scaledToFill()
          .frame(width: 58, height: 58)
          .clipShape(.rect(cornerRadius: 2))
      } else {
        Image(R.image.defaultDog)
      }
      Text((userManager.petList.first(where: { $0.petId == combiID })?.name).ifNil(then: ""))
        .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
        .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
    }
    .padding(EdgeInsets(top: 35, leading: 0, bottom: 19, trailing: 0))
    .frame(maxWidth: 154, maxHeight: 154, alignment: .top)
    .aspectRatio(1, contentMode: .fit)
    .background(Color(R.color.greyscale_02_252525))
    .clipShape(.rect(cornerRadius: 6))
    .overlay(alignment: .topTrailing) {
      Button {
        action()
      } label: {
        Image(R.image.pencil)
      }
      .padding(8)
    }
  }
}
