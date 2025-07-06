//
//  PrimaryActionLabel.swift
//  UserInterface
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct PrimaryActionLabel: View {
  
  let text: String
  let height: CGFloat
  let radius: CGFloat
  let foregroundColor: Color
  let backgroundColor: Color
  
  public init(
    text: String,
    height: CGFloat = 48,
    radius: CGFloat = 6,
    foregroundColor: Color = Color(R.color.gray_090909),
    backgroundColor: Color
  ) {
    self.text = text
    self.height = height
    self.radius = radius
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
  }
  
  public var body: some View {
    Text(text)
      .font(.pretendard(size: 18, weight: .semiBold))
      .foregroundStyle(foregroundColor)
      .frame(maxWidth: .infinity)
      .frame(height: height)
      .background(backgroundColor)
      .clipShape(.rect(cornerRadius: radius))
  }
}
