//
//  RunResult.swift
//  DomainExercise
//
//  Created by 임경빈 on 7/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct RunResult {
  public let runId: Int
  public let isFirstRun: Bool
  public let runCountOfMonth: Int
  
  public static var empty = RunResult(runId: 0, isFirstRun: false, runCountOfMonth: 0)
}
