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
  func requestKakaoLoginToken(token: String) async throws -> LoginResult
  func requestAppleLoginToken(token: String) async throws -> LoginResult
  func authRefresh(refreshToken: String) async throws
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
  
  public func requestKakaoLoginToken(token: String) async throws -> LoginResult {
    let jsonDict: [String: Any] = ["kakaoAccessToken": token]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/auth/kakao/login",
      resultType: ResultModel<LoginResultModel>.self,
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
  
  public func requestAppleLoginToken(token: String) async throws -> LoginResult {
    let jsonDict: [String: Any] = ["authorizationCode": token]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/auth/apple/login",
      resultType: ResultModel<LoginResultModel>.self,
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
  
  public func authRefresh(refreshToken: String) async throws {
    let headers: HTTPHeaders = [
      "RefreshToken": "Bearer \(refreshToken)"
    ]
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/auth/refresh",
      resultType: ResultModel<TokenResultModel>.self,
      method: .post,
      headers: headers
    )
    
    Logger.d("\(response)")
    if response.code == "STATUS200",
        let result = response.result,
        let accessToken = result.accessToken,
        let refreshToken = result.refreshToken {
      TokenManager.shared.handleLoginSuccess(accessToken: accessToken, refreshToken: refreshToken)
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
