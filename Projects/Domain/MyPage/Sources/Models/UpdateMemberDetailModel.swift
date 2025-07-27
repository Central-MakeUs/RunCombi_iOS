//
//  UpdateMemberDetailModel.swift
//  DomainMyPage
//
//  Created by 임경빈 on 7/27/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct UpdateMemberDetailModel: Codable {
  let nickname: String
  let gender: String // "MALE" or "FEMALE"
  let height: Int
  let weight: Int
  
  public init(nickname: String, gender: String, height: Int, weight: Int) {
    self.nickname = nickname
    self.gender = gender
    self.height = height
    self.weight = weight
  }
}
