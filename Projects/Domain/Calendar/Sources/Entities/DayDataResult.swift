//
//  DayDataResult.swift
//  DomainCalendar
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct DayDataResult: Hashable {
  public let runId: Int
  public let runTime: Int
  public let runDistance: Double
  public let runImageUrl: String
  public let regDate: String
}
