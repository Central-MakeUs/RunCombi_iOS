//
//  AnnouncementDetailView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 8/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainMyPage
import ResourceKit
import SharedUtility
import UserInterface

struct AnnouncementDetailView: View {
  @Environment(\.dismiss) var dismiss
  @Dependency(\.myPageClient) var myPageClient
  @State private var detail: AnnouncementDetail?
  @State private var isCopying = false
  let id: Int
  let type: AlarmTab
  @Binding var announcementList: [Announcement]
  
  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Button {
          dismiss()
        } label: {
          Image(R.image.backButton)
        }
        Spacer()
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      
      Divider()
        .frame(height: 1)
        .overlay(Color(R.color.greyscale_03_333333))
      
      if let detail {
        VStack(spacing: 8) {
          Text(detail.title)
            .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
            .foregroundStyle(Color(R.color.white_FFFFFF))
            .frame(maxWidth: .infinity, alignment: .leading)
          
          if type == .notice {
            Text("\(detail.regDate.formatDotDate())")
              .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .frame(maxWidth: .infinity, alignment: .leading)
          } else {
            Text(
              "기간: \(detail.startDate.formatDotDate())" +
              (detail.endDate.isEmpty ? "" : " ~ \(detail.endDate.formatDotDate())")
            )
            .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
            .frame(maxWidth: .infinity, alignment: .leading)
          }
        }
        .padding(.horizontal, 20)
        
        ScrollView {
          Text(.init(detail.content))
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .scrollIndicators(.never)
        .padding(.horizontal, 20)
        
        if let code = detail.code {
          VStack(alignment: .leading, spacing: 8) {
            Text("이벤트 코드")
              .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
            
            HStack {
              Text(code)
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .foregroundStyle(Color(R.color.greyscale_05_757575))
              
              Spacer()
              
              Button {
                UIPasteboard.general.string = code
                isCopying = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                  withAnimation {
                    isCopying = false
                  }
                }
              } label: {
                HStack(spacing: 4) {
                  isCopying ? Image(R.image.check) : Image(R.image.copy)
                  
                  Text(isCopying ? "복사완료" : "복사하기")
                    .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
                    .foregroundStyle(Color(R.color.blue_398AEC))
                }
              }
              .disabled(isCopying)
            }
            .padding(.horizontal, 16)
            .frame(height: 40)
            .background(Color(R.color.greyscale_03_333333))
            .clipShape(.rect(cornerRadius: 6))
          }
          .padding(.horizontal, 20)
        }
        
        if let urlString = detail.eventApplyUrl {
          Divider()
            .frame(height: 1)
            .overlay(Color(R.color.greyscale_03_333333))
            .padding(.top, 4)
          
          NavigationLink {
            NotionWebView(url: urlString)
          } label : {
            PrimaryActionLabel(
              text: "응모하기",
              height: 48,
              backgroundColor: Color(R.color.primary_01_D7FE63)
            )
          }
          .padding(.horizontal, 20)
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
    .task {
      await getAnnouncementDetail()
      await getAnnouncementList()
    }
  }
  
  private func getAnnouncementList() async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      announcementList = try await myPageClient.getAnnouncementList(token: token)
    } catch {
      Logger.e("\(error)")
    }
  }
  
  private func getAnnouncementDetail() async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      detail = try await myPageClient.getAnnouncementDetail(token: token, id: id)
    } catch {
      Logger.e("\(error)")
    }
  }
}
