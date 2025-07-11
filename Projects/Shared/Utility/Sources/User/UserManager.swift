//
//  UserManager.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public class UserManager: ObservableObject {
  @Published public var isLoggedIn: Bool = false
  @Published public var dogCount = 0
  public private(set) var id: String = ""
  public private(set) var nickname: String = ""
  public private(set) var photoURL: String = ""
  
  // MARK: - Initialize
  
  public init() {}
  public func saveUserInfo(id: String, name: String, photoURL: String?, dogCount: Int) {
    self.id = id
    self.nickname = name
    self.photoURL = photoURL ?? ""
    self.dogCount = dogCount
    isLoggedIn = true
  }
  
  public func clearUserInfo() {
    id = ""
    nickname = ""
    photoURL = ""
    dogCount = 0
    isLoggedIn = false
  }
  
  public func finishSignUp(dogCount: Int) {
    self.dogCount = dogCount
    isLoggedIn = true
  }
}
