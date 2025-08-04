//
//  AddRecordRequestModel.swift
//  DomainCalendar
//
//  Created by 임경빈 on 8/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct AddRunRequestModel: Encodable {
  public let memberRunStyle: String
  public let runTime: Int
  public let runDistance: Double
  public let regDate: String
  public let petCalList: [PetCal]

  public struct PetCal: Encodable {
    public let petId: Int
    
    public init(petId: Int) { self.petId = petId }
  }

  public init(
    memberRunStyle: String,
    runTime: Int,
    runDistance: Double,
    regDate: String,
    petCalList: [PetCal]
  ) {
    self.memberRunStyle = memberRunStyle
    self.runTime = runTime
    self.runDistance = runDistance
    self.regDate = regDate
    self.petCalList = petCalList
  }
}
