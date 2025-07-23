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

// 1) Giants 폰트 enum
public enum GiantsWeight: String, CaseIterable {
  /// Giants-Regular.otf
  case regular = "Giants-Regular"
  /// Giants-Inline.otf
  case inline  = "Giants-Inline"
  /// Giants-Bold.otf
  case bold    = "Giants-Bold"
}

// 2) FontWithLineHeight 뷰 모디파이어
struct GiantsFontWithLineHeight: ViewModifier {
  let size: CGFloat
  let weight: GiantsWeight
  let lineHeight: CGFloat

  func body(content: Content) -> some View {
    let fontName = weight.rawValue
    let uiFont = UIFont(name: fontName, size: size) ?? .systemFont(ofSize: size)
    let verticalPadding = (lineHeight - uiFont.lineHeight) / 2

    return content
      .font(.custom(fontName, size: size))
      .lineSpacing(lineHeight - uiFont.lineHeight)
      .padding(.vertical, verticalPadding)
  }
}

public struct CenteredShearEffect: GeometryEffect {
  /// 기울기 각도 (양수: 오른쪽 위로 기울어짐)
  var angle: Angle
  
  public init(angle: Angle) {
    self.angle = angle
  }

  public func effectValue(size: CGSize) -> ProjectionTransform {
    let f = CGFloat(tan(angle.radians))

    // 1) 뷰를 중앙으로 옮김
    let moveToCenter = CGAffineTransform(translationX: size.width * 0.55, y: 0)
    // 2) shear(비스듬히 기울이기)
    let shear = CGAffineTransform(a: 1, b: 0,
                                  c: f, d: 1,
                                  tx: 0, ty: 0)
    // 3) 다시 원위치로 이동
    let moveBack = CGAffineTransform(translationX: -size.width * 0.5, y: 0)

    // 이 세 개를 순서대로 합쳐서 적용
    let transform = moveToCenter.concatenating(shear).concatenating(moveBack)
    return ProjectionTransform(transform)
  }
}


// 3) View 확장: giantsFont modifier + 프리셋 메서드
public extension View {
  /// 범용 Giants 폰트 적용
  func giantsFont(
    size: CGFloat,
    weight: GiantsWeight = .regular,
    lineHeight: CGFloat
  ) -> some View {
    self.modifier(
      GiantsFontWithLineHeight(
        size: size,
        weight: weight,
        lineHeight: lineHeight
      )
    )
  }

  // === 사진 기준 프리셋 (size, gap 동일하게 사용) ===
  func heading1Giants() -> some View {
    giantsFont(size: 70, weight: .regular, lineHeight: 78)
  }
  func title1Giants() -> some View {
    giantsFont(size: 32, weight: .regular, lineHeight: 30)
  }
  func title2Giants() -> some View {
    giantsFont(size: 24, weight: .regular, lineHeight: 28)
  }
  func title3Giants() -> some View {
    giantsFont(size: 22, weight: .regular, lineHeight: 24)
  }
  func title4Giants() -> some View {
    giantsFont(size: 18, weight: .regular, lineHeight: 26)
  }
  func title5Giants() -> some View {
    giantsFont(size: 16, weight: .regular, lineHeight: 26)
  }
  func title6Giants() -> some View {
    giantsFont(size: 12, weight: .regular, lineHeight: 14)
  }
}
