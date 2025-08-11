//
//  AlarmView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 8/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainMyPage
import ResourceKit

enum AlarmTab: Int, CaseIterable {
  case notice, event
  var title: String {
    switch self {
    case .notice: return "공지"
    case .event:  return "이벤트"
    }
  }
}

struct AlarmView: View {
  @Environment(\.dismiss) var dismiss
  @State private var selection: AlarmTab = .notice
  @Binding var announcementList: [Announcement]
  @Namespace private var underlineNS
  
  var body: some View {
    VStack(spacing: 8) {
      ZStack {
        HStack {
          Button {
            dismiss()
          } label: {
            Image(R.image.backButton)
          }
          Spacer()
        }
        
        HStack {
          Spacer()
          Text("알림")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
            .foregroundStyle(Color(R.color.white_FFFFFF))
          Spacer()
        }
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      
      HStack {
        ForEach(AlarmTab.allCases, id: \.self) { tab in
          Button {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) {
              selection = tab
            }
          } label: {
            VStack(spacing: 9) {
              Text(tab.title)
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .foregroundStyle(selection == tab ? Color(R.color.greyscale_08_EDEDED) : Color(R.color.greyscale_07_B3B3B3))

              ZStack {
                if selection == tab {
                  Capsule()
                    .fill(Color(R.color.primary_01_D7FE63))
                    .frame(height: 2)
                    .matchedGeometryEffect(id: "underline", in: underlineNS)
                } else {
                  Capsule()
                    .fill(.clear)
                    .frame(height: 2)
                }
              }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
          }
        }
      }
      .background(Color(R.color.greyscale_01_171717))
      .padding(.top, 8)
      
      if selection == .notice {
        NoticeView(noticeList: announcementList.filter { $0.announcementType == "NOTICE" })
      } else if selection == .event {
        EventView(eventList: announcementList.filter { $0.announcementType == "EVENT" })
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
  }
}
