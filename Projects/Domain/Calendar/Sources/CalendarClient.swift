//
//  CalendarClient.swift
//  DomainCalendar
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Alamofire
import CoreNetwork
import Dependencies
import SharedUtility

public protocol CalendarClientProtocol {
  func fetchMonthData(token: String, year: Int, month: Int) async throws -> MonthDataResult
  func fetchDayData(token: String, year: Int, month: Int, day: Int) async throws -> [DayDataResult]
  func fetchRunDetail(token: String, runID: Int) async throws -> RunDetail
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
