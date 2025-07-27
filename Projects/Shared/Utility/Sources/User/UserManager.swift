//
//  UserManager.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public class UserManager: ObservableObject {
  @Published public var shouldRefresh: Bool = false
  @Published public var isLoggedIn: Bool = false
  @Published public var isSigning: Bool = false
  @Published public var isAgreementChecked: Bool = false
  @Published public var member: Member = .empty
  @Published public var petList: [Pet] = []
  
  // MARK: - Initialize
  
  public init() {}
  
  public func setUserManager(to data: MemberDetail) {
    member = data.member
    petList = data.petList
  }
  
  public func clearUserManager() {
    member = .empty
    petList = []
    isSigning = false
    isAgreementChecked = false
    isLoggedIn = false
  }
}
