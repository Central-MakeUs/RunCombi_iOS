//
//  MemberDetail.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/15/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct MemberDetail {
  let member: Member
  let petList: [Pet]
  public let memberStatus: MemberStatus
}

public struct Member {
  let memberId: Int
  let email: String
  let nickname: String
  let gender: String
  let height: Int
  let weight: Int
  let isActive: String
  let profileImgUrl: String
  let profileImgKey: String
  let memberTerms: [String]
}

public struct Pet {
  let petId: Int
  let name: String
  let age: Int
  let weight: Double
  let runStyle: String
  let petImageUrl: String
  let petImageKey: String
}
