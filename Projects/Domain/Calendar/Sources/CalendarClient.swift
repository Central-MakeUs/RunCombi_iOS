//
//  CalendarClient.swift
//  DomainCalendar
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import CoreNetwork
import Dependencies
import SharedUtility

public protocol CalendarClientProtocol {
  func fetchMonthData(token: String, year: Int, month: Int) async throws -> MonthDataResult
  func fetchDayData(token: String, year: Int, month: Int, day: Int) async throws -> [DayDataResult]
  func fetchRunDetail(token: String, runID: Int) async throws -> RunDetail
  func setRunEvaluating(token: String, runID: Int, evaluation: String) async throws
  func setRunImage(token: String, runID: Int, runImage: Data) async throws
  func updateRunMemo(token: String, runID: Int, memo: String) async throws
  func deleteRun(token: String, runID: Int) async throws
  func updateRunDetail(token: String, updateData: UpdateRecordRequestModel) async throws
  func addRun(token: String, addData: AddRunRequestModel) async throws
}

public final class CalendarClient: CalendarClientProtocol {
  
  public init() {}
  
  public func fetchMonthData(token: String, year: Int, month: Int) async throws -> MonthDataResult {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]

    let body = MonthDataRequestModel(year: year, month: month)
    let jsonData = try JSONEncoder().encode(body)

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/getMonthData",
      resultType: ResultModel<MonthDataResultModel>.self,
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
  
  public func fetchDayData(token: String, year: Int, month: Int, day: Int) async throws -> [DayDataResult] {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let body = DayDataRequestModel(year: year, month: month, day: day)
    let jsonData = try JSONEncoder().encode(body)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/getDayData",
      resultType: ResultModel<[DayDataResultModel]>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    
    Logger.d("DayData response: \(response)")
    if response.code == "STATUS200", let result = response.result {
      return result.map { $0.toEntity() }
    } else {
      throw ServerError.serverError
    }
  }
  
  public func fetchRunDetail(token: String, runID: Int) async throws -> RunDetail {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]

    let jsonDict: [String: Any] = ["runId": runID]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/getRunData",
      resultType: ResultModel<RunDetailModel>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )

    Logger.d("fetchRunData response: \(response)")

    if response.code == "STATUS200", let result = response.result {
      return result.toEntity()
    } else {
      throw ServerError.serverError
    }
  }
  
  public func setRunEvaluating(
    token: String,
    runID: Int,
    evaluation: String
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["runId": runID, "runEvaluating": evaluation]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/setRunEvaluating",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func setRunImage(
    token: String,
    runID: Int,
    runImage: Data
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]

    let runIdData = try JSONEncoder().encode("\(runID)")
    
    let jpegData: Data
    if let uiImage = UIImage(data: runImage),
       let compressed = uiImage.jpegData(compressionQuality: 0.7) {
      jpegData = compressed
    } else {
      // 변환 실패 시 원본 그대로
      jpegData = runImage
    }
    
    let response = try await Networking.shared.sendRequestWithFormData(
      "/api/calender/setRunImage",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    ) { multipartFormData in
      multipartFormData.append(runIdData, withName: "runId", mimeType: "application/json")
      multipartFormData.append(jpegData, withName: "runImage", fileName: "run\(runID).jpeg", mimeType: "image/jpeg")
    }

    Logger.d("setRunImage response: \(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func updateRunMemo(
    token: String,
    runID: Int,
    memo: String
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json"
    ]

    let jsonDict: [String: Any] = ["runId": runID, "memo": memo]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/updateMemo",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )

    Logger.d("updateRunMemo response: \(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func deleteRun(
    token: String,
    runID: Int
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-Type": "application/json"
    ]

    let jsonDict: [String: Any] = ["runId": runID]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/deleteRun",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )

    Logger.d("deleteRun response: \(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func updateRunDetail(
    token: String,
    updateData: UpdateRecordRequestModel
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]

    let jsonData = try JSONEncoder().encode(updateData)

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/updateRunDetail",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func addRun(
    token: String,
    addData: AddRunRequestModel
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonData = try JSONEncoder().encode(addData)

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/calender/addRun",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    Logger.d("addRun response: \(response)")

    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
}

public enum CalendarClientKey: DependencyKey {
  public static let liveValue: CalendarClientProtocol = CalendarClient()
}

public extension DependencyValues {
  var calendarClient: CalendarClientProtocol {
    get { self[CalendarClientKey.self] }
    set { self[CalendarClientKey.self] = newValue }
  }
}
