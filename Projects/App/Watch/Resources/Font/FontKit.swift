//
//  FontKit.swift
//  UserInterface
//
//  Created by 임경빈 on 7/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import CoreText

public enum PretendardWeight: String, CaseIterable {
  /// weight: 100
  case thin = "Pretendard-Thin"
  /// weight: 200
  case extraLight = "Pretendard-ExtraLight"
  /// weight: 300
  case light = "Pretendard-Light"
  /// weight: 400
  case regular = "Pretendard-Regular"
  /// weight: 500
  case medium = "Pretendard-Medium"
  /// weight: 600
  case semiBold = "Pretendard-SemiBold"
  /// weight: 700
  case bold = "Pretendard-Bold"
  /// weight: 800
  case extraBold = "Pretendard-ExtraBold"
  /// weight: 900
  case black = "Pretendard-Black"
}

public enum GiantsFont: String, CaseIterable {
  /// Giants-Regular.otf
  case regular = "Giants-Regular"
  /// Giants-Inline.otf
  case inline  = "Giants-Inline"
  /// Giants-Bold.otf
  case bold    = "Giants-Bold"
}

public enum FontKit {
  public static func registerPretendardFonts() {
    PretendardWeight.allCases.forEach { weight in
      let fontURL: URL? = {
          switch weight {
          case .thin:      return Bundle.main.url(forResource: "Pretendard-Thin", withExtension: "otf")
          case .extraLight:return Bundle.main.url(forResource: "Pretendard-ExtraLight", withExtension: "otf")
          case .light:     return Bundle.main.url(forResource: "Pretendard-Light", withExtension: "otf")
          case .regular:   return Bundle.main.url(forResource: "Pretendard-Regular", withExtension: "otf")
          case .medium:    return Bundle.main.url(forResource: "Pretendard-Medium", withExtension: "otf")
          case .semiBold:  return Bundle.main.url(forResource: "Pretendard-SemiBold", withExtension: "otf")
          case .bold:      return Bundle.main.url(forResource: "Pretendard-Bold", withExtension: "otf")
          case .extraBold: return Bundle.main.url(forResource: "Pretendard-ExtraBold", withExtension: "otf")
          case .black:     return Bundle.main.url(forResource: "Pretendard-Black", withExtension: "otf")
          }
      }()
      
      guard let url = fontURL,
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) else {
        print("❌ Failed to register font: \(weight.rawValue)")
        return
      }
    }
  }
  
  public static func registerGiantsFonts() {
    GiantsFont.allCases.forEach { font in
      // SwiftGen R.file 혹은 번들에서 URL을 꺼내오는 부분
      let fontURL: URL? = {
          switch font {
          case .regular:
              return Bundle.main.url(forResource: "Giants-Regular", withExtension: "otf")
          case .inline:
              return Bundle.main.url(forResource: "Giants-Inline", withExtension: "otf")
          case .bold:
              return Bundle.main.url(forResource: "Giants-Bold", withExtension: "otf")
          }
      }()
      
      guard
        let url = fontURL,
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
      else {
        print("❌ Failed to register Giants font: \(font.rawValue)")
        return
      }
    }
  }
}
