//
//  Font+Extensions.swift
//  UserInterface
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public extension Font {
  // MARK: - Typography presets
  static var heading1: Font { .pretendard(size: 28, weight: .semiBold) }
  static var title2: Font   { .pretendard(size: 22, weight: .semiBold) }
  static var title3: Font   { .pretendard(size: 20, weight: .semiBold) }
  static var title4: Font   { .pretendard(size: 18, weight: .semiBold) }
  
  static var body1: Font    { .pretendard(size: 16, weight: .medium) }
  static var body2: Font    { .pretendard(size: 14, weight: .medium) }
  static var body3: Font    { .pretendard(size: 12, weight: .semiBold) }
  
  static func pretendard(size: CGFloat, weight: PretendardWeight = .regular) -> Font {
    .custom(weight.rawValue, size: size)
  }
}

// MARK: - Typography + Modifier

public enum TypographyStyle {
  case heading1, title2, title3, title4
  case body1, body2, body3
  
  public var font: Font {
    switch self {
    case .heading1: return .heading1
    case .title2:   return .title2
    case .title3:   return .title3
    case .title4:   return .title4
    case .body1:    return .body1
    case .body2:    return .body2
    case .body3:    return .body3
    }
  }
  
  public var lineSpacing: CGFloat {
    switch self {
    case .heading1: return (40 - 28) / 2
    case .title2:   return (34 - 22) / 2
    case .title3:   return (32 - 20) / 2
    case .title4:   return (30 - 18) / 2
    case .body1:    return (26 - 16) / 2
    case .body2:    return (24 - 14) / 2
    case .body3:    return (22 - 12) / 2
    }
  }
}

public struct TypographyModifier: ViewModifier {
  let style: TypographyStyle
  
  public func body(content: Content) -> some View {
    content
      .font(style.font)
      .lineSpacing(style.lineSpacing)
  }
}

public extension View {
  func customFont(_ style: TypographyStyle) -> some View {
    self.modifier(TypographyModifier(style: style))
  }
}

struct FontWithLineHeight: ViewModifier {
  let size: CGFloat
  let weight: PretendardWeight
  let lineHeight: CGFloat
  
  func body(content: Content) -> some View {
    let fontName = weight.rawValue
    let uiFont = UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    let verticalPadding = (lineHeight - uiFont.lineHeight) / 2
    
    return content
      .font(Font.custom(fontName, size: size))
      .lineSpacing(lineHeight - uiFont.lineHeight)
      .padding(.vertical, verticalPadding)
  }
}

public extension View {
  func pretendardFont(size: CGFloat, weight: PretendardWeight = .regular, lineHeight: CGFloat) -> some View {
    self.modifier(FontWithLineHeight(size: size, weight: weight, lineHeight: lineHeight))
  }
}
