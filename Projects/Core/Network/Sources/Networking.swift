//
//  Networking.swift
//  CoreNetwork
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Alamofire
import SharedUtility

public final class Networking {
  public static let shared = Networking()
  private let baseURL = "http://api.runcombi.site"
  
  // MARK: Initialize
  
  private init() {}
  
  // MARK: Requests
  
  public func sendRequest<T: Decodable>(
    _ url: String,
    resultType: T.Type,
    method: HTTPMethod,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default
  ) async throws -> T {
    if !NetworkMonitor.shared.isConnected {
      throw NetworkError.disconected
    }
    
    return try await AF.request(
      baseURL.appending(url),
      method: method,
      parameters: parameters,
      encoding: encoding
    )
    .validate()
    .serializingDecodable()
    .value
  }
  
  public func sendRequestWithRaw<T: Decodable>(
    _ url: String,
    resultType: T.Type,
    method: HTTPMethod,
    rawBody: Data? = nil,
    headers: HTTPHeaders = .default
  ) async throws -> T {
    if !NetworkMonitor.shared.isConnected {
      throw NetworkError.disconected
    }
    
    var urlRequest = try URLRequest(url: baseURL + url, method: method)
    
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    headers.forEach { header in
      urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
    }
    
    if let body = rawBody {
      urlRequest.httpBody = body
    }
    
    return try await AF.request(urlRequest)
      .validate()
      .serializingDecodable(resultType)
      .value
  }
  
  public func sendRequestWithFormData<T: Decodable>(
    _ url: String,
    resultType: T.Type,
    method: HTTPMethod = .post,
    headers: HTTPHeaders = .default,
    formDataBuilder: @escaping (MultipartFormData) -> Void
  ) async throws -> T {
    if !NetworkMonitor.shared.isConnected {
      throw NetworkError.disconected
    }
    
    return try await withCheckedThrowingContinuation { continuation in
      AF.upload(
        multipartFormData: formDataBuilder,
        to: baseURL + url,
        method: method,
        headers: headers
      )
      .validate()
      .responseDecodable(of: resultType) { response in
        switch response.result {
        case .success(let result):
          continuation.resume(returning: result)
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
