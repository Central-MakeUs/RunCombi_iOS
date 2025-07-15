//
//  MemberStatus.swift
//  DomainLogin
//
//  Created by 임경빈 on 7/15/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum MemberStatus: String {
  /// 약관 동의를 진행하지 않은 회원
  case pendingAgree = "PENDING_AGREE"
  /// 회원 정보를 입력하지 않은 회원
  case pendingMemberDetail = "PENDING_MEMBER_DETAIL"
  /// 정상 회원
  case live = "LIVE"
  /// 알 수 없는 상태
  case unknown
  
  public init(rawValue: String) {
    switch rawValue {
    case "PENDING_AGREE": self = .pendingAgree
    case "PENDING_MEMBER_DETAIL": self = .pendingMemberDetail
    case "LIVE": self = .live
    default: self = .unknown
    }
  }
}
