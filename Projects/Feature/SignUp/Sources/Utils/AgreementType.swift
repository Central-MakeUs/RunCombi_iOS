//
//  AgreementType.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

enum AgreementType: CaseIterable {
  case terms
  case privacy
  case location
}

extension AgreementType {
  var stringKey: String.LocalizationValue {
    switch self {
    case .terms:
      "SignUp.Agreement.TermsOfService.Required"
    case .privacy:
      "SignUp.Agreement.PrivacyPolicy.Required"
    case .location:
      "SignUp.Agreement.LocationTerms.Required"
    }
  }
}
