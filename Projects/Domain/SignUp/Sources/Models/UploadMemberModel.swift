//
//  UploadMemberModel.swift
//  DomainSignUp
//
//  Created by 임경빈 on 7/16/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct UploadMemberModel: Codable {
  public let nickname: String
  public let gender: String
  public let height: Int
  public let weight: Int
  
  public init(nickname: String, gender: String, height: Int, weight: Int) {
    self.nickname = nickname
    self.gender = gender
    self.height = height
    self.weight = weight
  }
}
