//
//  FontKit.swift
//  UserInterface
//
//  Created by 임경빈 on 7/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import ResourceKit
import SwiftUI
import ResourceKit
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

public enum FontKit {
  public static func registerPretendardFonts() {
    PretendardWeight.allCases.forEach { weight in
      let fontURL: URL? = {
        switch weight {
        case .thin: return R.file.pretendardThinOtf()
        case .extraLight: return R.file.pretendardExtraLightOtf()
        case .light: return R.file.pretendardLightOtf()
        case .regular: return R.file.pretendardRegularOtf()
        case .medium: return R.file.pretendardMediumOtf()
        case .semiBold: return R.file.pretendardSemiBoldOtf()
        case .bold: return R.file.pretendardBoldOtf()
        case .extraBold: return R.file.pretendardExtraBoldOtf()
        case .black: return R.file.pretendardBlackOtf()
        }
      }()
      
      guard let url = fontURL,
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil) else {
        print("❌ Failed to register font: \(weight.rawValue)")
        return
      }
    }
  }
}
