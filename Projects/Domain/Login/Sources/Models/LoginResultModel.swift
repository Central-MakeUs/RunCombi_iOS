//
//  KakaoLoginResultModel.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

struct LoginResultModel: Codable {
  let memberId: String?
  let email: String?
  let accessToken: String?
  let refreshToken: String?
  let finishRegister: String?
  
  func toEntity() -> LoginResult {
    return LoginResult(
      memberId: memberId.ifNil(then: ""),
      email: email.ifNil(then: ""),
      accessToken: accessToken.ifNil(then: ""),
      refreshToken: refreshToken.ifNil(then: ""),
      finishRegister: finishRegister.ifNil(then: "")
    )
  }
}
