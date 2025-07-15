//
//  MemberDetailModel.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/15/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation
import SharedUtility

struct MemberDetailModel: Codable {
  let member: MemberModel?
  let petList: [PetModel]?
  let memberStatus: String?
  
  func toEntity() -> MemberDetail {
    return MemberDetail(
      member: (member?.toEntity()).ifNil(then: Member(
        memberId: 0,
        email: "",
        nickname: "",
        gender: "",
        height: 0,
        weight: 0,
        isActive: "",
        profileImgUrl: "",
        profileImgKey: "",
        memberTerms: [])
      ),
      petList: (petList?.map { $0.toEntity() }).ifNil(then: []),
      memberStatus: MemberStatus(rawValue: memberStatus ?? "")
    )
  }
}

// MARK: - Member 정보
struct MemberModel: Codable {
  let memberId: Int?
  let email: String?
  let nickname: String?
  let gender: String?
  let height: Int?
  let weight: Int?
  let isActive: String?
  let profileImgUrl: String?
  let profileImgKey: String?
  let memberTerms: [String]?
  
  func toEntity() -> Member {
    return Member(
      memberId: memberId ?? 0,
      email: email ?? "",
      nickname: nickname ?? "",
      gender: gender ?? "",
      height: height ?? 0,
      weight: weight ?? 0,
      isActive: isActive ?? "",
      profileImgUrl: profileImgUrl ?? "",
      profileImgKey: profileImgKey ?? "",
      memberTerms: memberTerms ?? []
    )
  }
}

// MARK: - Pet 정보
struct PetModel: Codable {
  let petId: Int?
  let name: String?
  let age: Int?
  let weight: Double?
  let runStyle: String?
  let petImageUrl: String?
  let petImageKey: String?
  
  func toEntity() -> Pet {
    return Pet(
      petId: petId ?? 0,
      name: name ?? "",
      age: age ?? 0,
      weight: weight ?? 0.0,
      runStyle: runStyle ?? "",
      petImageUrl: petImageUrl ?? "",
      petImageKey: petImageKey ?? ""
    )
  }
}
