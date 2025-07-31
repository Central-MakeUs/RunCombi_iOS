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
  func endRun(token: String, requestModel: EndRunRequestModel, routeImage: Data?) async throws
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
    if response.code == "STATUS200", let result = response.result {
      return result.toEntity()
    } else {
      throw ServerError.serverError
    }
  }
  
  public func endRun(
    token: String,
    requestModel: EndRunRequestModel,
    routeImage: Data?,
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]

    let memberRunJSON = try JSONEncoder().encode(requestModel.memberRunData)
    let petRunJSON = try JSONEncoder().encode(requestModel.petRunData)

    let response = try await Networking.shared.sendRequestWithFormData(
      "/api/run/endRun",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    ) { multipartFormData in
      multipartFormData.append(memberRunJSON, withName: "memberRunData", mimeType: "application/json")
      multipartFormData.append(petRunJSON, withName: "petRunData", mimeType: "application/json")
      if let routeImage {
        multipartFormData.append(routeImage, withName: "routeImage", fileName: "routeImage.png", mimeType: "image/png")
      }
    }

    Logger.d("endRun response: \(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
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
