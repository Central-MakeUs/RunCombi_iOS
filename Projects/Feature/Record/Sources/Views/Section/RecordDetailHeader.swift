//
//  RecordDetailHeader.swift
//  FeatureRecord
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import PhotosUI
import SwiftUI

import Dependencies
import DomainCalendar
import Kingfisher
import ResourceKit
import SharedUtility

struct RecordDetailHeader: View {
  @Dependency(\.calendarClient) var calendarClient
  @Environment(\.dismiss) var dismiss
  @Binding var runDetail: RunDetail
  @Binding var isMenuPresented: Bool
  @Binding var selectedImageData: Data?
  
  @State private var currentTab: Int = 1
  @State private var routeImageURL = ""
  @State private var runImageURL = ""
  var hasRunImage: Bool {
    URL(string: runImageURL) != nil || selectedImageData != nil
  }
  
  @State private var isPhotosPickerPresented: Bool = false
  @State private var selectedPicture: PhotosPickerItem?
  
  var body: some View {
    ZStack(alignment: .top) {
      Color(R.color.greyscale_02_252525)
      
      if let routeImageUrl = URL(string: routeImageURL), hasRunImage {
        TabView(selection: $currentTab) {
          Group {
            if let runImageURL = URL(string: runImageURL) {
              KFImage(runImageURL)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
              Image(uiImage: uiImage)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
          }
          .tag(1)
          
          KFImage(routeImageUrl)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .tag(2)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment: .bottomTrailing) {
          Text("\(currentTab) / 2")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
            .background(Color(R.color.greyscale_03_333333).opacity(0.8))
            .clipShape(.rect(cornerRadius: 2))
            .padding(18)
        }
      } else if let routeImageUrl = URL(string: routeImageURL) {
        KFImage(routeImageUrl)
          .resizable()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else if hasRunImage {
        if let runImageURL = URL(string: runImageURL) {
          KFImage(runImageURL)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
          Image(uiImage: uiImage)
            .resizable()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
      } else {
        VStack(spacing: 52) {
          Text("찍은 운동 사진이 없어요,,,")
            .giantsFont(size: 18, weight: .regular, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_04_525252))
          
          Button {
            isPhotosPickerPresented = true
          } label: {
            HStack(spacing: 8) {
              Image(R.image.album)
              Text("사진 추가하기")
                .pretendardFont(size: 18, weight: .semiBold, lineHeight: 21)
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            }
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(Color(R.color.greyscale_03_333333))
            .clipShape(.rect(cornerRadius: 6))
          }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
      }
      
      HStack(spacing: 8) {
        Button {
          dismiss()
        } label: {
          Image(R.image.backButton)
        }
        
        Text((runDetail.regDate.toKoreanDateFormat()).ifNil(then: ""))
          .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
          .foregroundStyle(Color(R.color.white_FFFFFF))
        
        Spacer()
        
        Button {
          withAnimation {
            isMenuPresented = true
          }
        } label: {
          Image(R.image.menu)
        }
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
    }
    .frame(height: 264)
    .onChange(of: runDetail) {
      routeImageURL = runDetail.routeImageUrl
      runImageURL = runDetail.runImageUrl
    }
    .photosPicker(
      isPresented: $isPhotosPickerPresented,
      selection: $selectedPicture,
      matching: .all(of: [.not(.videos)])
    )
    .onChange(of: selectedPicture) {
      Task {
        if let data = try? await selectedPicture?.loadTransferable(type: Data.self) {
          setRunImage(to: data)
        }
      }
    }
  }
  
  private func setRunImage(to data: Data) {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.setRunImage(token: token, runID: runDetail.runId, runImage: data)
        selectedImageData = data
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
