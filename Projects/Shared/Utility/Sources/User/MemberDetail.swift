//
//  MemberDetail.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/15/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct MemberDetail {
  public let member: Member
  public let petList: [Pet]
  public let memberStatus: MemberStatus
  
  public init(member: Member, petList: [Pet], memberStatus: MemberStatus) {
    self.member = member
    self.petList = petList
    self.memberStatus = memberStatus
  }
  
  public static var empty = MemberDetail(member: Member.empty, petList: [], memberStatus: .unknown)
}

public struct Member {
  let memberId: Int
  public let provider: SNSType
  let email: String
  public let nickname: String
  public let gender: GenderType
  public let height: Int
  public let weight: Int
  let isActive: String
  public let profileImgUrl: String
  let profileImgKey: String
  let memberTerms: [String]
  
  public init(memberId: Int, provider: String, email: String, nickname: String, gender: String, height: Int, weight: Int, isActive: String, profileImgUrl: String, profileImgKey: String, memberTerms: [String]) {
    self.memberId = memberId
    self.provider = SNSType.convertSNSType(provider)
    self.email = email
    self.nickname = nickname
    self.gender = GenderType.convertGenderType(gender)
    self.height = height
    self.weight = weight
    self.isActive = isActive
    self.profileImgUrl = profileImgUrl
    self.profileImgKey = profileImgKey
    self.memberTerms = memberTerms
  }
  
  static var empty = Member(memberId: 0, provider: "", email: "", nickname: "", gender: "", height: 0, weight: 0, isActive: "", profileImgUrl: "", profileImgKey: "", memberTerms: [])
}

public struct Pet: Hashable {
  public let petId: Int
  public let name: String
  public let age: Int
  public let weight: Double
  public let runStyle: WalkStyleType
  public let petImageUrl: String
  let petImageKey: String
  
  public init(petId: Int, name: String, age: Int, weight: Double, runStyle: String, petImageUrl: String, petImageKey: String) {
    self.petId = petId
    self.name = name
    self.age = age
    self.weight = weight
    self.runStyle = WalkStyleType.convertWalkStyleType(runStyle)
    self.petImageUrl = petImageUrl
    self.petImageKey = petImageKey
  }
}
