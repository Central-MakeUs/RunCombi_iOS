//
//  DateFormatter+Extension.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/30/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public extension DateFormatter {
  static let yyyyMMdd: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "yyyyMMdd"
    f.locale = Locale(identifier: "ko_KR")
    return f
  }()
  
  static let yyyyMMddwitDdot: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy.MM.dd"
    return df
  }()
  
  static let HHmm: DateFormatter = {
    let tf = DateFormatter()
    tf.dateFormat = "HH:mm"
    return tf
  }()
}

