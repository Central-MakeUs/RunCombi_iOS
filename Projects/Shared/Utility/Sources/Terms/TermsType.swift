//
//  TermsType.swift
//  SharedUtility
//
//  Created by Groonui on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum TermsType {
  case serviceTerms
  case personalPrivacy
  case locationTerms
}

extension TermsType {
  public var urlString: String {
    switch self {
    case .serviceTerms:
      "https://encouraging-potential-f2d.notion.site/2366951266db80dabc10c701a65875fe?pvs=74"
    case .personalPrivacy:
      "https://encouraging-potential-f2d.notion.site/2366951266db8035ad23c11c502fd243?pvs=74"
    case .locationTerms:
      "https://encouraging-potential-f2d.notion.site/2366951266db80efabead10fb511a343?pvs=74"
    }
  }
}
