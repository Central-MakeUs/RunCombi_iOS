//
//  KakaoLoginResult.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct KakaoLoginResult {
  let memberId: String
  let email: String
  let accessToken: String
  let refreshToken: String
  let finishRegister: String
}
