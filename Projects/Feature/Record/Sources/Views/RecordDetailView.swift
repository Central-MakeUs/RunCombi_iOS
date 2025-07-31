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
import ResourceKit
import SharedUtility

public struct RecordDetailView: View {
  @Dependency(\.calendarClient) var calendarClient
  private let id: Int
  @State private var runDetail: RunDetail = .empty
  
  public init(of id: Int) {
    self.id = id
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack {
        RecordDetailHeader(runDetail: $runDetail)
        
        Spacer()
      }
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
      Logger.d("\(runDetail)") //
    } catch {
      Logger.e("\(error)")
    }
  }
}
