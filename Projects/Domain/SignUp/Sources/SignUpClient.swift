//
//  SignUpClient.swift
//  DomainSignUp
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Alamofire
import CoreNetwork
import Dependencies
import SharedUtility

public protocol SignUpClientProtocol {
  func setMemberTerms(token: String) async throws
}

public final class SignUpClient: SignUpClientProtocol {
  
  public init() {}
  
  public func setMemberTerms(token: String) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["agreeTermList": ["TERMS_OF_SERVICE", "PRIVACY_POLICY", "LOCATION_SERVICE_AGREEMENT"]]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/member/setMemberTerms",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    Logger.d("\(response)")
  }
}

public enum SignUpClientKey: DependencyKey {
  public static let liveValue: SignUpClientProtocol = SignUpClient()
}

public extension DependencyValues {
  var signUpClient: SignUpClientProtocol {
    get { self[SignUpClientKey.self] }
    set { self[SignUpClientKey.self] = newValue }
  }
}
