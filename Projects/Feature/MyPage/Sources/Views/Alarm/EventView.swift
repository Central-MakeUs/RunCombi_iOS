//
//  EventView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 8/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainMyPage
import ResourceKit

struct EventView: View {
  let eventList: [Announcement]
  @Binding var announcementList: [Announcement]
  
  var body: some View {
    ScrollView {
      ForEach(eventList, id: \.announcementId) { event in
        NavigationLink {
          AnnouncementDetailView(id: event.announcementId, type: .event, announcementList: $announcementList)
        } label: {
          VStack(spacing: .zero) {
            VStack(alignment: .leading, spacing: 4) {
              HStack {
                Text(event.title)
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                Spacer()
                Image(R.image.pushButton)
              }
              
              Text(
                "\(event.startDate.formatDotDate())" +
                (event.endDate.isEmpty ? "" : " ~ \(event.endDate.formatDotDate())")
              )
              .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
            }
            .padding(.vertical, 18)
            
            Divider()
              .frame(height: 1)
              .overlay(Color(R.color.greyscale_03_333333))
          }
          .padding(.horizontal, 20)
          .background(event.isRead ? Color.clear : Color(R.color.greyscale_02_252525))
        }
      }
    }
    .scrollIndicators(.never)
  }
}
