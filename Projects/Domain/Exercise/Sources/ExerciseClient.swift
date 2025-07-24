//
//  ExerciseClient.swift
//  DomainSignUp
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Alamofire
import CoreNetwork
import Dependencies
import SharedUtility

public protocol ExerciseClientProtocol {
  func startRun(token: String, petList: [Int], memberRunStyle: WalkStyleType) async throws -> RunResult
}

public final class ExerciseClient: ExerciseClientProtocol {
  
  public init() {}
  
  public func startRun(
    token: String,
    petList: [Int],
    memberRunStyle: WalkStyleType
  ) async throws -> RunResult {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["petList": petList, "memberRunStyle": memberRunStyle.serverValue]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/run/startRun",
      resultType: ResultModel<RunResultModel>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    } else {
      return (response.result?.toEntity()).ifNil(then: RunResult.empty)
    }
  }
}

public enum ExerciseClientKey: DependencyKey {
  public static let liveValue: ExerciseClientProtocol = ExerciseClient()
}

public extension DependencyValues {
  var exerciseClient: ExerciseClientProtocol {
    get { self[ExerciseClientKey.self] }
    set { self[ExerciseClientKey.self] = newValue }
  }
}
