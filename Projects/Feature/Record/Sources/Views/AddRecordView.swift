//
//  AddRecordView.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainCalendar
import Kingfisher
import ResourceKit
import SharedUtility
import UserInterface

public struct AddRecordView: View {
  @Dependency(\.calendarClient) var calendarClient
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var userManager: UserManager
  
  @State private var isCancelSheetPresented = false
  @State private var isPickerPresented = false
  @State private var startDate: Date = Date()
  @State private var typpedDistance: String = ""
  @State private var typpedTime: String = ""
  @State private var selectedPets: [Pet] = []
  @State private var selectedMemberWalkStyle: WalkStyleType = .none
  
  var isDisabled: Bool {
    typpedDistance.isEmpty ||
    typpedTime.isEmpty ||
    selectedMemberWalkStyle == .none ||
    selectedPets.isEmpty
  }
  
  @Binding var selectedDate: Date?
  @Binding var isPresented: Bool
  let onSaved: (Int) -> Void

  public init(
    of selectedDate: Binding<Date?>,
    isPresented: Binding<Bool>,
    onSaved: @escaping (Int) -> Void
  ) {
    self._selectedDate = selectedDate
    self._isPresented = isPresented
    self.onSaved = onSaved
  }
  
  public var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        EditHeader(title: "기록 추가", isDisabled: isDisabled)
        {
          isCancelSheetPresented = true
        } saveAction: {
          addRecord()
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
            
            VStack(spacing: 16) {
              Text("함께한 콤비는")
                .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
                .foregroundStyle(Color(R.color.white_FFFFFF))
                .frame(maxWidth: .infinity, alignment: .leading)
              
              SelectDogView(selectedPets: $selectedPets)
            }
            
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
        .scrollIndicators(.hidden)
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
      .frame(maxWidth: .infinity)
      .background(Color(R.color.greyscale_01_171717))
    }
    .onAppear {
      UIApplication.shared.hideKeyboard()
      startDate = (selectedDate).ifNil(then: Date())
      AppAnalytics.shared.logScreen("record_add")
    }
    .bottomSheet(isPresented: $isPickerPresented) {
      RecordDatePickerSheet(isPresented: $isPickerPresented, startDate: $startDate)
    }
    .bottomSheet(isPresented: $isCancelSheetPresented) {
      CancelRecordBottomSheet(isPresented: $isCancelSheetPresented)
    }
  }
  
  private func addRecord() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        let result = try await calendarClient.addRun(token: token, addData: AddRunRequestModel(
          memberRunStyle: selectedMemberWalkStyle.serverValue,
          runTime: Int(typpedTime).ifNil(then: 0),
          runDistance: Double(typpedDistance).ifNil(then: 0),
          regDate: startDate.toServerDateString(),
          petCalList: selectedPets.map { pet in
            AddRunRequestModel.PetCal(petId: pet.petId)
          }
        ))
        let daysAgo = Calendar.current.dateComponents(
          [.day],
          from: Calendar.current.startOfDay(for: startDate),
          to: Calendar.current.startOfDay(for: Date())
        ).day.ifNil(then: 0)
        AppAnalytics.shared.log(.recordAdd(
          durationMin: Int(typpedTime).ifNil(then: 0),
          distanceKm: Double(typpedDistance).ifNil(then: 0),
          petCount: selectedPets.count,
          daysAgo: daysAgo
        ))
        // 저장 완료 후 입력 화면을 닫고 부모(캘린더)에서 기록 상세로 이동
        isPresented = false
        onSaved(result.runId)
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
