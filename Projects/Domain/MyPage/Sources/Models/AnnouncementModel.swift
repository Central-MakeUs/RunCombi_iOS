//
//  AnnouncementModel.swift
//  DomainMyPage
//
//  Created by 임경빈 on 8/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

struct AnnouncementModel: Codable {
  let announcementId: Int?
  let announcementType: String?
  let title: String?
  let startDate: String?
  let endDate: String?
  let regDate: String?
  let isRead: String?
  
  func toEntity() -> Announcement {
    return Announcement(
      announcementId: announcementId.ifNil(then: 0),
      announcementType: announcementType.ifNil(then: ""),
      title: title.ifNil(then: ""),
      startDate: startDate.ifNil(then: ""),
      endDate: endDate.ifNil(then: ""),
      regDate: regDate.ifNil(then: ""),
      isRead: isRead == "Y"
    )
  }
}
