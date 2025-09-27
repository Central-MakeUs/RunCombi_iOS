//
//  TokenResultModel.swift
//  DomainLogin
//
//  Created by 임경빈 on 9/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

struct TokenResultModel: Codable {
  let refreshToken: String?
  let accessToken: String?
}
