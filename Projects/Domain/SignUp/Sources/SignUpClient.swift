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
  func setMemberDetail(
    token: String,
    memberDetail: UploadMemberModel,
    petDetail: UploadPetModel,
    memberImageData: Data?,
    petImageData: Data?
  ) async throws
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
      "/api/member/setMemberTerms",
      resultType: ResultModel<String>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func setMemberDetail(
    token: String,
    memberDetail: UploadMemberModel,
    petDetail: UploadPetModel,
    memberImageData: Data?,
    petImageData: Data?
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-type": "multipart/form-data"
    ]
    
    // JSON 객체 -> Data
    let memberJSONData = try JSONEncoder().encode(memberDetail)
    let petJSONData = try JSONEncoder().encode(petDetail)
    
    let response = try await Networking.shared.sendRequestWithFormData(
      "/api/member/setMemberDetail",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    ) { multipartFormData in
      multipartFormData.append(memberJSONData, withName: "memberDetail", mimeType: "application/json")
      multipartFormData.append(petJSONData, withName: "pet", mimeType: "application/json")
      if let memberImageData {
        multipartFormData.append(memberImageData, withName: "memberImage", fileName: "member.png", mimeType: "image/png")
      }
      if let petImageData {
        multipartFormData.append(petImageData, withName: "petImage", fileName: "pet.png", mimeType: "image/png")
      }
    }
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
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
