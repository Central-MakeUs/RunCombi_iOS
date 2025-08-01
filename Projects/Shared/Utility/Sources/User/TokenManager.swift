//
//  TokenManager.swift
//  SharedUtility
//
//  Created by Groonui on 7/14/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation
import KeychainAccess

public class TokenManager {
  public static let shared = TokenManager()
  
  private init() {}
  
  private let keychain = Keychain(service: "com.Combo.RunCombi")
  
  public var accessToken: String? {
    get { try? keychain.get("accessToken") }
    set { try? keychain.set(newValue ?? "", key: "accessToken") }
  }
  
  public var refreshToken: String? {
    get { try? keychain.get("refreshToken") }
    set { try? keychain.set(newValue ?? "", key: "refreshToken") }
  }
  
  public var appleUserID: String? {
    get { try? keychain.get("appleUserID") }
    set { try? keychain.set(newValue ?? "", key: "appleUserID") }
  }
  
  public func isLoggedIn() -> Bool {
    return accessToken != nil
  }
  
  public func handleLoginSuccess(accessToken: String, refreshToken: String) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
  
  public func setAppleUserID(to id: String) {
    self.appleUserID = id
  }
  
  public func clearTokens() {
    do {
      try keychain.remove("accessToken")
      try keychain.remove("refreshToken")
      try keychain.remove("appleUserID")
    } catch let error {
      print("토큰 삭제 중 오류 발생: \(error)")
    }
  }
}
