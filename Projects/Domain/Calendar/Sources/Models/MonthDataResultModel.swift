//
//  MonthDataResultModel.swift
//  DomainCalendar
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

struct MonthDataResultModel: Codable {
  let monthData: [MonthDayRunDataModel]
  let avgTime: Int?
  let avgCal: Int?
  let avgDistance: Double?
  let totalTime: Int?
  let totalCal: Int?
  let totalDistance: Double?
  let mostRunStyle: String?

  func toEntity() -> MonthDataResult {
    MonthDataResult(
      monthData: monthData.compactMap { $0.toEntity() },
      avgTime: avgTime.ifNil(then: 0),
      avgCal: avgCal.ifNil(then: 0),
      avgDistance: avgDistance.ifNil(then: 0),
      totalTime: totalTime.ifNil(then: 0),
      totalCal: totalCal.ifNil(then: 0),
      totalDistance: totalDistance.ifNil(then: 0),
      mostRunStyle: mostRunStyle.ifNil(then: "")
    )
  }
}

struct MonthDayRunDataModel: Codable {
  let date: String? // "20250720"
  let runId: [Int]?
  
  func toEntity() -> MonthDayRunData? {
    guard let date = date, let runId = runId else {
      return nil
    }
    return MonthDayRunData(date: date, runId: runId)
  }
}
