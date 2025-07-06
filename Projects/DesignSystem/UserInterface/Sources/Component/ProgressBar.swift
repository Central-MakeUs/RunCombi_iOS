//
//  ProgressBar.swift
//  UserInterface
//
//  Created by 임경빈 on 7/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public struct ProgressBar: View {
  
  // MARK: - Properties
  
  private var value: Double
  private var height: CGFloat
  private var foregroundColor: Color
  private var backgroundColor: Color
  private var radius: CGFloat
  
  // MARK: - Initialize
  
  private init(
    value: Double,
    height: CGFloat,
    foregroundColor: Color,
    backgroundColor: Color,
    radius: CGFloat
  ) {
    self.value = value
    self.height = height
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
    self.radius = radius
  }
  
  // MARK: - Factory
  
  public static func create(
    value: Double,
    height: CGFloat,
    foregroundColor: Color = Color.blue,
    backgroundColor: Color = Color.gray,
    radius: CGFloat = 8
  ) -> ProgressBar {
    return ProgressBar(
      value: value,
      height: height,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      radius: radius
    )
  }
  
  // MARK: - Views
  
  public var body: some View {
    GeometryReader { geometry in
      let normalizedValue = CGFloat(max(0, min(value, 1)))

      ZStack(alignment: .leading) {
        Rectangle()
          .frame(height: height)
          .foregroundStyle(backgroundColor)
        
        RoundedRectangle(cornerRadius: radius)
          .frame(width: normalizedValue * geometry.size.width, height: height)
          .foregroundColor(foregroundColor)
          .animation(.linear, value: UUID())
      }
      .clipShape(.rect(cornerRadius: radius))
    }
    .frame(height: height)
  }
}
