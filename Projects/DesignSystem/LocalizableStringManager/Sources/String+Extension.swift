//
//  String+Extension.swift
//  LocalizableStringManager
//
//  Created by 임경빈 on 4/1/25.
//  Copyright © 2025 com.deepfine. All rights reserved.
//

import Foundation

public extension String {
  init(key: LocalizationValue) {
    self = String(localized: key, bundle: Bundle.module)
  }
}
