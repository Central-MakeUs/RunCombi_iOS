//
//  RunDetail.swift
//  DomainCalendar
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct RunDetail: Codable, Equatable {
  public let runId: Int
  public let nickname: String
  public let profileImgUrl: String
  public let runTime: Int
  public let runDistance: Double
  public let memberRunStyle: String
  public let memberCal: Int
  public let runEvaluating: String
  public let runImageUrl: String
  public let routeImageUrl: String
  public let memo: String
  public let regDate: String
  public let petData: [RunPetDetail]
  
  public static var empty = RunDetail(runId: 0, nickname: "", profileImgUrl: "", runTime: 0, runDistance: 0, memberRunStyle: "", memberCal: 0, runEvaluating: "", runImageUrl: "", routeImageUrl: "", memo: "", regDate: "", petData: [])
}

public struct RunPetDetail: Codable, Hashable {
  let petId: Int
  public let name: String
  public let petImageUrl: String
  public let petCal: Int
}
