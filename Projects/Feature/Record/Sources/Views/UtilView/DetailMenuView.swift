//
//  DetailMenuView.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import PhotosUI
import SwiftUI

import Dependencies
import DomainCalendar
import ResourceKit
import SharedUtility

struct DetailMenuView: View {
  @Dependency(\.calendarClient) var calendarClient

  @Binding var isMenuPresented: Bool
  @Binding var isDeleteRecordSheetPresented: Bool
  @Binding var runDetail: RunDetail
  @Binding var selectedImageData: Data?
  
  @State private var isEditRecordViewPresented: Bool = false
  @State private var isPhotosPickerPresented: Bool = false
  @State private var selectedPicture: PhotosPickerItem?
  
  var body: some View {
    ZStack(alignment: .top) {
      Color(R.color.black_212121)
        .opacity(0.76)
        .ignoresSafeArea()
        .onTapGesture {
          withAnimation {
            isMenuPresented = false
          }
        }
      
      HStack {
        Spacer()
        VStack(alignment: .trailing, spacing: 10) {
          Button {
            withAnimation {
              isMenuPresented = false
            }
          } label: {
            Image(R.image.menu)
          }
          
          VStack(spacing: 12) {
            Button {
              isEditRecordViewPresented = true
            } label: {
              HStack(spacing: 12) {
                Image(R.image.pencil)
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 16, height: 16)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                
                Text("기록 편집")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              }
            }
            
            Button {
              isPhotosPickerPresented = true
            } label: {
              HStack(spacing: 12) {
                Image(R.image.album)
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 16, height: 16)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                
                Text(runDetail.runImageUrl.isEmpty ? "사진 추가" : "사진 변경")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              }
            }
            
            Button {
              isDeleteRecordSheetPresented = true
            } label: {
              HStack(spacing: 12) {
                Image(R.image.trash)
                  .resizable()
                  .frame(width: 16, height: 16)
                
                Text("기록 삭제")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.red_B04A4A))
              }
            }
          }
          .padding(EdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16))
          .background(Color(R.color.greyscale_02_252525))
          .clipShape(.rect(cornerRadius: 6))
          .contentShape(.rect)
        }
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
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
      .fullScreenCover(isPresented: $isEditRecordViewPresented) {
        EditRecordView(runDetail: $runDetail)
      }
    }
  }
  
  private func setRunImage(to data: Data) {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.setRunImage(token: token, runID: runDetail.runId, runImage: data)
        selectedImageData = data
        withAnimation {
          isMenuPresented = false
        }
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
