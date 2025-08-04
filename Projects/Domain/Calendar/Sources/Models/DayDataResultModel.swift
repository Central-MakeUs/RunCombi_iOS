//
//  DayDataResultModel.swift
//  DomainCalendar
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

struct DayDataResultModel: Codable {
  let runId: Int?
  let runTime: Int?
  let runDistance: Double?
  let runImageUrl: String?
  let regDate: String?
  
  func toEntity() -> DayDataResult {
    DayDataResult(
      runId: runId.ifNil(then: 0),
      runTime: runTime.ifNil(then: 0),
      runDistance: runDistance.ifNil(then: 0),
      runImageUrl: runImageUrl.ifNil(then: ""),
      regDate: regDate.ifNil(then: "")
    )
  }
}
