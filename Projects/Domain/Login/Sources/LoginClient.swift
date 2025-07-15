//
//  LoginClient.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Alamofire
import CoreNetwork
import Dependencies
import SharedUtility

public protocol LoginClientProtocol {
  func getMemberDetail(token: String) async throws -> MemberDetail
  func requestKakaoLoginToken(token: String) async throws -> KakaoLoginResult
}

public final class LoginClient: LoginClientProtocol {
  
  public init() {}
  
  public func getMemberDetail(token: String) async throws -> MemberDetail {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/member/getMemberDetail",
      resultType: ResultModel<MemberDetailModel>.self,
      method: .post,
      headers: headers
    )
    
    Logger.d("\(response)")
    if response.code == "STATUS200", let result = response.result {
      return result.toEntity()
    } else {
      throw ServerError.serverError
    }
  }
  
  public func requestKakaoLoginToken(token: String) async throws -> KakaoLoginResult {
    let jsonDict: [String: Any] = ["kakaoAccessToken": token]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/auth/kakao/login",
      resultType: ResultModel<KakaoLoginResultModel>.self,
      method: .post,
      rawBody: jsonData
    )
    
    Logger.d("\(response)")
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
