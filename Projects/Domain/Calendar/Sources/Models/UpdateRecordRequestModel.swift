//
//  UpdateRecordRequestModel.swift
//  DomainCalendar
//
//  Created by 임경빈 on 8/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public struct UpdateRecordRequestModel: Encodable {
  public let runId: Int
  public let regDate: String           // "yyyy-MM-dd'T'HH:mm:ss" 포맷
  public let memberRunStyle: String
  public let runTime: Int
  public let runDistance: Double
  
  public init(
    runId: Int,
    regDate: String,
    memberRunStyle: String,
    runTime: Int,
    runDistance: Double
  ) {
    self.runId = runId
    self.regDate = regDate
    self.memberRunStyle = memberRunStyle
    self.runTime = runTime
    self.runDistance = runDistance
  }
}
