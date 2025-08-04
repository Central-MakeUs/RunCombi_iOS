//
//  RunDetailModel.swift
//  DomainCalendar
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct RunDetailModel: Codable {
  let runId: Int?
  let nickname: String?
  let profileImgUrl: String?
  let runTime: Int?
  let runDistance: Double?
  let memberRunStyle: String?
  let memberCal: Int?
  let runEvaluating: String?
  let runImageUrl: String?
  let routeImageUrl: String?
  let memo: String?
  let regDate: String?
  let petData: [RunPetDetailModel]
  
  func toEntity() -> RunDetail {
    return RunDetail(
      runId: runId ?? 0,
      nickname: nickname ?? "",
      profileImgUrl: profileImgUrl ?? "",
      runTime: runTime ?? 0,
      runDistance: runDistance ?? 0.0,
      memberRunStyle: memberRunStyle ?? "",
      memberCal: memberCal ?? 0,
      runEvaluating: runEvaluating ?? "",
      runImageUrl: runImageUrl ?? "",
      routeImageUrl: routeImageUrl ?? "",
      memo: memo ?? "",
      regDate: regDate ?? "",
      petData: petData.map { $0.toEntity() }
    )
  }
}

public struct RunPetDetailModel: Codable {
  let petId: Int?
  let name: String?
  let petImageUrl: String?
  let petCal: Int?
  
  func toEntity() -> RunPetDetail {
    return RunPetDetail(
      petId: petId ?? 0,
      name: name ?? "",
      petImageUrl: petImageUrl ?? "",
      petCal: petCal ?? 0
    )
  }
}
