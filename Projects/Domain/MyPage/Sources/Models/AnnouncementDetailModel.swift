//
//  AnnouncementDetailModel.swift
//  DomainMyPage
//
//  Created by 임경빈 on 8/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

struct AnnouncementDetailModel: Codable {
  let announcementId: Int?
  let announcementType: String?
  let title: String?
  let content: String?
  let announcementImageUrl: String?
  let code: String?
  let eventApplyUrl: String?
  let startDate: String?
  let endDate: String?
  let regDate: String?
  
  func toEntity() -> AnnouncementDetail {
    return AnnouncementDetail(
      announcementId: announcementId.ifNil(then: 0),
      announcementType: announcementType.ifNil(then: ""),
      title: title.ifNil(then: ""),
      content: content.ifNil(then: ""),
      announcementImageUrl: announcementImageUrl.ifNil(then: ""),
      code: code,
      eventApplyUrl: eventApplyUrl,
      startDate: startDate.ifNil(then: ""),
      endDate: endDate.ifNil(then: ""),
      regDate: regDate.ifNil(then: "")
    )
  }
}
