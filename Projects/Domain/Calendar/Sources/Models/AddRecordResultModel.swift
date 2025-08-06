//
//  AddRecordResultModel.swift
//  DomainCalendar
//
//  Created by 임경빈 on 8/7/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Foundation

import SharedUtility

struct AddRecordResultModel: Codable {
  let runId: Int?
  
  func toEntity() -> AddRecordResult {
    return AddRecordResult(
      runId: runId.ifNil(then: 0)
    )
  }
}
