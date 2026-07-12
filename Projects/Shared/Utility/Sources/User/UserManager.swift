//
//  UserManager.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public class UserManager: ObservableObject {
  @Published public var shouldRefresh: Bool = false // userManager 새로고침
  @Published public var isLoggedIn: Bool = false // 메인 화면으로 이동
  @Published public var isSigning: Bool = false // 로그인 후, 회원가입 화면으로 이동
  @Published public var isAgreementChecked: Bool = false // 회원가입 중 서비스 동의 체크한 경우, 바로 정보 입력 화면으로 이동
  @Published public var shouldNavigateMyPage: Bool = false // 회원가입 후 콤비 추가 시 마이페이지로 이동
  @Published public var isDeleteAccountSnackBarPresented: Bool = false // 회원탈퇴 후, 스낵바 관리
  
  @Published public var member: Member = .empty
  @Published public var petList: [Pet] = []
  
  // MARK: - Initialize
  
  public init() {}
  
  public func setUserManager(to data: MemberDetail) {
    member = data.member
    petList = data.petList
    AppAnalytics.shared.setUserProperty(
      .petCount,
      value: petList.count >= 3 ? "3+" : "\(petList.count)"
    )
  }
  
  public func clearUserManager() {
    member = .empty
    petList = []
    isSigning = false
    isAgreementChecked = false
    isLoggedIn = false
    shouldNavigateMyPage = false
    shouldRefresh = false
  }
}
