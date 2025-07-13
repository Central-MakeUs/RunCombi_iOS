//
//  LoginClient.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import CoreNetwork
import Dependencies
import SharedUtility

public protocol LoginClientProtocol {
  func requestKakaoLoginToken(token: String) async throws -> KakaoLoginResult
}

public final class LoginClient: LoginClientProtocol {
  
  public init() {}
  
  public func requestKakaoLoginToken(token: String) async throws -> KakaoLoginResult {
    let jsonDict: [String: Any] = ["kakaoAccessToken": token]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/auth/kakao/login",
      resultType: ResultModel<KakaoLoginResultModel>.self,
      method: .post,
      rawBody: jsonData
    )
    
    if response.code == "STATUS200", let result = response.result {
      return result.toEntity()
    } else {
      throw ServerError.serverError
    }
  }
}

public enum LoginClientKey: DependencyKey {
  public static let liveValue: LoginClientProtocol = LoginClient()
}

public extension DependencyValues {
  var loginClient: LoginClientProtocol {
    get { self[LoginClientKey.self] }
    set { self[LoginClientKey.self] = newValue }
  }
}
