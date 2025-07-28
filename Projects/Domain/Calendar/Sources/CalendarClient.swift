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

}

public final class CalendarClient: CalendarClientProtocol {
  
  public init() {}
  
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
