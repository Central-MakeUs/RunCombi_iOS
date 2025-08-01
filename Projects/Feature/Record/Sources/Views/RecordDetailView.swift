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
  
  public init(of id: Int) {
    self.id = id
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 0) {
        RecordDetailHeader(runDetail: $runDetail, isMenuPresented: $isMenuPresented)
        
        ScrollView {
          VStack(alignment: .leading, spacing: 32) {
            VStack(alignment: .leading, spacing: 12) {
              Text("함께 운동한 시간")
                .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
                .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
              HStack(alignment: .bottom) {
                HStack(alignment: .bottom, spacing: 0) {
                  Text("\(runDetail.runTime) ")
                    .giantsFont(size: 36, weight: .regular, lineHeight: 30)
                    .foregroundColor(Color(R.color.ff_F4F4F4))
                    .modifier(CenteredShearEffect(angle: .degrees(-12)))
                  Text("min")
                    .giantsFont(size: 20, weight: .regular, lineHeight: 20)
                    .foregroundColor(Color(R.color.ff_F4F4F4))
                    .modifier(CenteredShearEffect(angle: .degrees(-12)))
                }
                
                Spacer()
                
                HStack(alignment: .bottom, spacing: 0) {
                  Text("\(String(format: "%.2f", runDetail.runDistance)) ")
                    .giantsFont(size: 22, weight: .regular, lineHeight: 22)
                    .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
                    .modifier(CenteredShearEffect(angle: .degrees(-12)))
                  Text("km")
                    .giantsFont(size: 16, weight: .regular, lineHeight: 20)
                    .foregroundColor(Color(R.color.greyscale_06_999999))
                    .modifier(CenteredShearEffect(angle: .degrees(-12)))
                }
              }
            }
            .padding(.top, 40)
            
            DetailKcalSection(runDetail: runDetail)
            
            DetailEvaluationSection(runDetail: $runDetail)
            
            DetailMemoSection(runDetail: runDetail)
              .padding(.bottom, 20)
          }
          .padding(.horizontal, 20)
        }
      }
      
      DetailMenuView(isMenuPresented: $isMenuPresented, runDetail: $runDetail)
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
