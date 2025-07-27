//
//  AddPetDetailModel.swift
//  DomainMyPage
//
//  Created by 임경빈 on 7/27/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

public struct AddPetDetailModel: Codable {
  let name: String
  let age: Int
  let weight: Double
  let runStyle: String
  
  public init(name: String, age: Int, weight: Double, runStyle: WalkStyleType) {
    self.name = name
    self.age = age
    self.weight = weight
    self.runStyle = runStyle.serverValue
  }
}
