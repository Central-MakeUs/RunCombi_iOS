//
//  EndRunRequestModel.swift
//  DomainExercise
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct EndRunRequestModel: Codable {
  let memberRunData: MemberRunData
  let petRunData: PetRunData
  
  public init(memberRunData: MemberRunData, petRunData: PetRunData) {
    self.memberRunData = memberRunData
    self.petRunData = petRunData
  }
}

public struct MemberRunData: Codable {
  let runId: Int
  let runTime: Int
  let runDistance: Double
  
  public init(runId: Int, runTime: Int, runDistance: Double) {
    self.runId = runId
    self.runTime = runTime
    self.runDistance = runDistance
  }
}

public struct PetRunData: Codable {
  let petCalList: [PetCal]
  
  public init(petCalList: [PetCal]) {
    self.petCalList = petCalList
  }
}

public struct PetCal: Codable {
  let petId: Int
  
  public init(petId: Int) {
    self.petId = petId
  }
}
