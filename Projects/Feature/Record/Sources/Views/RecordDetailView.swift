//
//  RecordDetailView.swift
//  FeatureCalendar
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainCalendar
import Kingfisher
import ResourceKit
import SharedUtility
import UserInterface

public struct RecordDetailView: View {
  @Dependency(\.calendarClient) var calendarClient
  private let id: Int
  @State private var runDetail: RunDetail = .empty
  @State private var isMenuPresented = false
  @State private var selectedImageData: Data? = nil
  
  public init(of id: Int) {
    self.id = id
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        RecordDetailHeader(runDetail: $runDetail, isMenuPresented: $isMenuPresented, selectedImageData: $selectedImageData)
        
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
      
      DetailMenuView(isMenuPresented: $isMenuPresented, runDetail: $runDetail, selectedImageData: $selectedImageData)
        .opacity(isMenuPresented ? 1 : 0)
    }
    .navigationBarBackButtonHidden()
    .task {
      await fetchDetail()
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
}
