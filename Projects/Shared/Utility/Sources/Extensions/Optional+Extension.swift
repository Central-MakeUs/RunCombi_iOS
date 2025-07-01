//
//  Optional+Extension.swift
//  SharedUtility
//
//  Created by 임경빈 on 4/25/25.
//  Copyright © 2025 com.deepfine. All rights reserved.
//

import Foundation

public extension Optional {
  func ifNil(then value: Wrapped) -> Wrapped {
    return (self ?? value)
  }
  
  static func isNil(_ object: Wrapped) -> Bool {
    switch object as Any {
    case Optional<Any>.none:
      return true
    default:
      return false
    }
  }
}
