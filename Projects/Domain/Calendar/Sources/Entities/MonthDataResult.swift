//
//  MonthDataResult.swift
//  DomainCalendar
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct MonthDataResult {
  public let monthData: [MonthDayRunData]
  public let avgTime: Int
  public let avgCal: Int
  public let avgDistance: Double
  public let totalTime: Int
  public let totalCal: Int
  public let totalDistance: Double
  public let mostRunStyle: String
}

public struct MonthDayRunData {
  public let date: String
  public let runId: [Int]
}
