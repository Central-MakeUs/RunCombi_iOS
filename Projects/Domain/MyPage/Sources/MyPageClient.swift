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
  func updatePetDetail(token: String, updatePetDetail: UpdatePetDetailModel, petImageData: Data?) async throws
  func addPet(token: String, petDetail: AddPetDetailModel, petImageData: Data?) async throws
  func deletePet(token: String, petID: Int) async throws
  func getDeleteData(token: String) async throws -> DeleteDataResult
  func sendLeaveReason(token: String, reason: [String]) async throws
  func deleteAccount(token: String) async throws
  func suggestion(token: String, message: String) async throws
  func getAnnouncementList(token: String) async throws -> [Announcement]
  func getAnnouncementDetail(token: String, id: Int) async throws -> AnnouncementDetail
  func checkVersion(version: String) async throws -> Bool
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
  
  public func updatePetDetail(
    token: String,
    updatePetDetail: UpdatePetDetailModel,
    petImageData: Data?
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-type": "multipart/form-data"
    ]
    
    // JSON 객체 -> Data
    let petJSONData = try JSONEncoder().encode(updatePetDetail)
    
    let response = try await Networking.shared.sendRequestWithFormData(
      "/api/pet/updatePetDetail",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    ) { multipartFormData in
      multipartFormData.append(petJSONData, withName: "updatePetDetail", mimeType: "application/json")
      if let petImageData {
        multipartFormData.append(petImageData, withName: "petImage", fileName: "pet.png", mimeType: "image/png")
      }
    }
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func addPet(
    token: String,
    petDetail: AddPetDetailModel,
    petImageData: Data?
  ) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)",
      "Content-type": "multipart/form-data"
    ]
    
    // JSON 객체 -> Data
    let petJSONData = try JSONEncoder().encode(petDetail)
    
    let response = try await Networking.shared.sendRequestWithFormData(
      "/api/pet/addPet",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    ) { multipartFormData in
      multipartFormData.append(petJSONData, withName: "pet", mimeType: "application/json")
      if let petImageData {
        multipartFormData.append(petImageData, withName: "petImage", fileName: "pet.png", mimeType: "image/png")
      }
    }
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func deletePet(token: String, petID: Int) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["deletePetId": petID]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/pet/deletePet",
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
  
  public func getDeleteData(token: String) async throws -> DeleteDataResult {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]

    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/member/getDeleteData",
      resultType: ResultModel<DeleteDataResultModel>.self,
      method: .post,
      headers: headers
    )
    Logger.d("getDeleteData response: \(response)")

    if response.code == "STATUS200", let result = response.result {
      return result.toEntity()
    } else {
      throw ServerError.serverError
    }
  }
  
  public func sendLeaveReason(token: String, reason: [String]) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["reason": reason]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/member/leaveReason",
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
  
  public func deleteAccount(token: String) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/member/deleteAccount",
      resultType: ResultModel<String>.self,
      method: .post,
      headers: headers
    )
    
    Logger.d("\(response)")
    if response.code != "STATUS200" {
      throw ServerError.serverError
    }
  }
  
  public func suggestion(token: String, message: String) async throws {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["sggMsg": message]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/api/member/suggestion",
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
  
  public func getAnnouncementList(token: String) async throws -> [Announcement] {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/announcement/getAnnouncementList",
      resultType: ResultListModel<AnnouncementModel>.self,
      method: .post,
      headers: headers
    )
    Logger.d("\(response)")
    if response.code == "STATUS200", let result = response.result {
      return result.map { $0.toEntity() }
    } else {
      throw ServerError.serverError
    }
  }
  
  public func getAnnouncementDetail(token: String, id: Int) async throws -> AnnouncementDetail {
    let headers: HTTPHeaders = [
      "Authorization": "Bearer \(token)"
    ]
    
    let jsonDict: [String: Any] = ["announcementId": id]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/announcement/getAnnouncementDetail",
      resultType: ResultModel<AnnouncementDetailModel>.self,
      method: .post,
      rawBody: jsonData,
      headers: headers
    )
    Logger.d("\(response)")
    if response.code == "STATUS200", let result = response.result {
      return result.toEntity()
    } else {
      throw ServerError.serverError
    }
  }
  
  public func checkVersion(version: String) async throws -> Bool {
    let jsonDict: [String: Any] = ["os": "iOS", "version": version]
    let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
    
    let response = try await Networking.shared.sendRequestWithRaw(
      "/version/check",
      resultType: ResultModel<VersionModel>.self,
      method: .post,
      rawBody: jsonData
    )
    Logger.d("\(response)")
    if response.code == "STATUS200", let result = response.result {
      return result.updateRequire == "Y"
    } else {
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
