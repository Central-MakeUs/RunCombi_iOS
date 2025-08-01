//
//  KakaoLoginResult.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct LoginResult {
  let memberId: String
  let email: String
  public let accessToken: String
  public let refreshToken: String
  public let finishRegister: String
}
