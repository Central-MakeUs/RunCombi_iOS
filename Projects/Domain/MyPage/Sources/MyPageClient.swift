//
//  MyPageClient.swift
//  DomainMyPage
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Alamofire
import CoreNetwork
import Dependencies
import SharedUtility

public protocol MyPageClientProtocol {
  func updateMemberDetail(token: String, updateMemberDetail: UpdateMemberDetailModel, memberImageData: Data?) async throws
}

public final class MyPageClient: MyPageClientProtocol {
  
  public init() {}
  
  public func updateMemberDetail(
    token: String,
    updateMemberDetail: UpdateMemberDetailModel,
    memberImageData: Data?
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-type": "multipart/form-data"
    ]
    
    // JSON 객체 -> Data
    let memberJSONData = try JSONEncoder().encode(updateMemberDetail)
    
    let response = try await Networking.shared.sendRequestWithFormData(
      "/api/member/updateMemberDetail",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    ) { multipartFormData in
      multipartFormData.append(memberJSONData, withName: "updateMemberDetail", mimeType: "application/json")
      if let memberImageData {
        multipartFormData.append(memberImageData, withName: "memberImage", fileName: "member.png", mimeType: "image/png")
      }
    }
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
}

public enum MyPageClientKey: DependencyKey {
  public static let liveValue: MyPageClientProtocol = MyPageClient()
}

public extension DependencyValues {
  var myPageClient: MyPageClientProtocol {
    get { self[MyPageClientKey.self] }
    set { self[MyPageClientKey.self] = newValue }
  }
}
