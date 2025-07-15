//
//  UploadPetModel.swift
//  DomainSignUp
//
//  Created by 임경빈 on 7/16/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct UploadPetModel: Codable {
  public let name: String
  public let age: Int
  public let weight: Double
  public let runStyle: String
  
  public init(name: String, age: Int, weight: Double, runStyle: String) {
    self.name = name
    self.age = age
    self.weight = weight
    self.runStyle = runStyle
  }
}
