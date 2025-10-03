//
//  RecordDetailView.swift
//  FeatureCalendar
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
import UserInterface

public struct RecordDetailView: View {
  @Environment(\.dismiss) var dismiss
  @Dependency(\.calendarClient) var calendarClient
  private let id: Int
  @Binding var snackBarItem: String
  let popAction: (() -> Void)?
  
  @State private var runDetail: RunDetail = .empty
  @State private var isMenuPresented = false
  @State private var selectedImageData: Data? = nil
  @State private var isDeleteRecordSheetPresented: Bool = false
  @State private var isSelectImageSheetPresented: Bool = false
  @State private var isCropSheetPresented: Bool = false
  
  @State private var isCameraPresented: Bool = false
  @State private var isPhotosPickerPresented: Bool = false
  @State private var selectedPicture: PhotosPickerItem?
  
  public init(of id: Int, snackBarItem: Binding<String>, popAction: (() -> Void)? = nil) {
    self.id = id
    self._snackBarItem = snackBarItem
    self.popAction = popAction
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        RecordDetailHeader(
          runDetail: $runDetail,
          isMenuPresented: $isMenuPresented,
          isSelectImageSheetPresented: $isSelectImageSheetPresented,
          selectedImageData: $selectedImageData
        ) {
          if let popAction {
            popAction()
          } else {
            dismiss()
          }
        }
        
        ScrollView {
          VStack(alignment: .leading, spacing: 32) {
            DetailInfoSection(runDetail: $runDetail)
              .padding(.top, 40)
            
            DetailKcalSection(runDetail: runDetail)
            
            DetailEvaluationSection(runDetail: $runDetail)
            
            DetailMemoSection(runDetail: runDetail)
              .padding(.bottom, 20)
          }
          .padding(.horizontal, 20)
        }
      }
      
      DetailMenuView(
        isMenuPresented: $isMenuPresented,
        isDeleteRecordSheetPresented: $isDeleteRecordSheetPresented,
        isSelectImageSheetPresented: $isSelectImageSheetPresented,
        runDetail: $runDetail,
        selectedImageData: $selectedImageData
      )
      .opacity(isMenuPresented ? 1 : 0)
    }
    .navigationBarBackButtonHidden()
    .task {
      await fetchDetail()
    }
    .bottomSheet(isPresented: $isSelectImageSheetPresented) {
      SelectImageBottomSheet(
        isPresented: $isSelectImageSheetPresented,
        isCameraPresented: $isCameraPresented,
        isPhotosPickerPresented: $isPhotosPickerPresented
      )
    }
    .bottomSheet(isPresented: $isDeleteRecordSheetPresented) {
      DeleteRecordBottomSheet(
        runDetail: $runDetail,
        isPresented: $isDeleteRecordSheetPresented,
        snackBarItem: $snackBarItem,
        popAction: popAction
      )
    }
    .fullScreenCover(isPresented: $isCameraPresented) {
      CameraView { image in
        if let data = image.pngData() {
          selectedImageData = data
          isCropSheetPresented = true
        }
      }
      .ignoresSafeArea()
    }
    .photosPicker(
      isPresented: $isPhotosPickerPresented,
      selection: $selectedPicture,
      matching: .all(of: [.not(.videos)])
    )
    .fullScreenCover(isPresented: $isCropSheetPresented) {
      CropBoxView(selectedImageData: $selectedImageData) {
        if let data = selectedImageData {
          setRunImage(to: data)
        }
        isCropSheetPresented = false
      }
    }
    .onChange(of: selectedPicture) {
      Task {
        if let data = try? await selectedPicture?.loadTransferable(type: Data.self) {
          selectedImageData = data
          isCropSheetPresented = true
        }
      }
    }
  }
  
  private func fetchDetail() async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      runDetail = try await calendarClient.fetchRunDetail(token: token, runID: id)
    } catch {
      Logger.e("\(error)")
    }
  }
  
  private func setRunImage(to data: Data) {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.setRunImage(token: token, runID: runDetail.runId, runImage: data)
        runDetail = try await calendarClient.fetchRunDetail(token: token, runID: runDetail.runId)
        selectedImageData = data
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
