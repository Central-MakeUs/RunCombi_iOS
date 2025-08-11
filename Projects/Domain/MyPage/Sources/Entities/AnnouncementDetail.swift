//
//  AnnouncementDetail.swift
//  DomainMyPage
//
//  Created by 임경빈 on 8/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public struct AnnouncementDetail {
  public let announcementId: Int
  public let announcementType: String
  public let title: String
  public let content: String
  public let announcementImageUrl: String
  public let code: String?
  public let eventApplyUrl: String?
  public let startDate: String
  public let endDate: String
  public let regDate: String
}
