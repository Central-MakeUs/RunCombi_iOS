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
