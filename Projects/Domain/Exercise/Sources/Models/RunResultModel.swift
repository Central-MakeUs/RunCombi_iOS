//
//  RunResultModel.swift
//  DomainExercise
//
//  Created by 임경빈 on 7/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

struct RunResultModel: Codable {
  let runId: Int?
  let isFirstRun: String?
  let nthRun: Int?
  
  func toEntity() -> RunResult {
    return RunResult(
      runId: runId.ifNil(then: 0),
      isFirstRun: isFirstRun == "Y",
      runCountOfMonth: nthRun.ifNil(then: 0)
    )
  }
}
