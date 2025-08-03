//
//  EditRecordView.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainCalendar
import ResourceKit
import SharedUtility
import UserInterface

struct EditRecordView: View {
  @Dependency(\.calendarClient) var calendarClient
  @Environment(\.dismiss) var dismiss
  @Binding var runDetail: RunDetail
  
  @State private var isPickerPresented = false
  @State private var startDate: Date = Date()
  @State private var typpedDistance: String = ""
  @State private var typpedTime: String = ""
  @State private var selectedMemberWalkStyle: WalkStyleType = .none
  
  var body: some View {
    VStack(spacing: 0) {
      EditHeader(title: "기록 편집", isDisabled: false) {
        saveEditRecord()
      }
      
      ScrollView {
        VStack(spacing: 24) {
          VStack(spacing: 12) {
            Button {
              isPickerPresented = true
            } label: {
              HStack {
                Text("시작 일시")
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(Color(R.color.greyscale_06_999999))
                
                Spacer()
                
                HStack(spacing: 9) {
                  Text(DateFormatter.yyyyMMddwitDdot.string(from: startDate))
                    .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                    .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  
                  Text(DateFormatter.HHmm.string(from: startDate))
                    .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                    .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                }
              }
              .frame(height: 44)
              .padding(.horizontal, 12)
              .background(Color(R.color.greyscale_03_333333))
              .clipShape(.rect(cornerRadius: 6))
            }
            
            HStack(spacing: 12) {
              HStack {
                Text("거리")
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(Color(R.color.greyscale_06_999999))
                
                Spacer()
                
                HStack(spacing: 4) {
                  TextField(
                    "",
                    text: $typpedDistance,
                    prompt: Text("0.00")
                      .foregroundStyle(Color(R.color.greyscale_06_999999))
                  )
                  .keyboardType(.decimalPad)
                  .multilineTextAlignment(.trailing)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .onChange(of: typpedDistance) { oldValue, newValue in
                    
                  }
                  
                  Text("km")
                    .foregroundStyle(Color(R.color.greyscale_06_999999))
                    .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                }
              }
              .frame(height: 44)
              .padding(.horizontal, 12)
              .background(Color(R.color.greyscale_03_333333))
              .clipShape(.rect(cornerRadius: 6))
              
              
              HStack {
                Text("시간")
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(Color(R.color.greyscale_06_999999))
                
                Spacer()
                
                HStack(spacing: 4) {
                  TextField(
                    "",
                    text: $typpedTime,
                    prompt: Text("0")
                      .foregroundStyle(Color(R.color.greyscale_06_999999))
                  )
                  .keyboardType(.numberPad)
                  .multilineTextAlignment(.trailing)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .onChange(of: typpedTime) { oldValue, newValue in
                    if let time = Int(typpedTime), time > 999 {
                      typpedTime = oldValue
                    }
                  }
                  
                  Text("min")
                    .foregroundStyle(Color(R.color.greyscale_06_999999))
                    .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                }
              }
              .frame(height: 44)
              .padding(.horizontal, 12)
              .background(Color(R.color.greyscale_03_333333))
              .clipShape(.rect(cornerRadius: 6))
            }
          }
          .padding(.top, 32)
          
          VStack(alignment: .leading, spacing: 20) {
            Text("이번 운동은")
              .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            
            VStack(spacing: 12) {
              ForEach(WalkStyleType.allCases.reversed(), id: \.self) { type in
                if type != .none {
                  Button {
                    selectedMemberWalkStyle = type
                  } label: {
                    Text(type.memberRunStyle)
                      .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
                      .foregroundStyle(selectedMemberWalkStyle == type ? Color(R.color.greyscale_03_333333):  Color(R.color.greyscale_08_EDEDED))
                      .padding(EdgeInsets(top: 9, leading: 12, bottom: 9, trailing: 12))
                      .frame(maxWidth: .infinity)
                      .background(selectedMemberWalkStyle == type ? Color(R.color.primary_01_D7FE63):  Color(R.color.greyscale_04_525252))
                      .clipShape(.rect(cornerRadius: 6))
                  }
                }
              }
            }
          }
        }
      }
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .onAppear {
      UIApplication.shared.hideKeyboard()
      startDate = (runDetail.regDate.toDate()).ifNil(then: Date())
      typpedDistance = String(runDetail.runDistance)
      typpedTime = String(runDetail.runTime)
      selectedMemberWalkStyle = WalkStyleType.convertWalkStyleType(runDetail.memberRunStyle)
    }
    .bottomSheet(isPresented: $isPickerPresented) {
      RecordDatePickerSheet(isPresented: $isPickerPresented, startDate: $startDate)
    }
  }
  
  private func saveEditRecord() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.updateRunDetail(
          token: token,
          updateData: UpdateRecordRequestModel(
            runId: runDetail.runId,
            regDate: startDate.toServerDateString(),
            memberRunStyle: selectedMemberWalkStyle.serverValue,
            runTime: Int(typpedTime).ifNil(then: 0),
            runDistance: Double(typpedDistance).ifNil(then: 0)
          )
        )
        runDetail = try await calendarClient.fetchRunDetail(token: token, runID: runDetail.runId)
        dismiss()
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
