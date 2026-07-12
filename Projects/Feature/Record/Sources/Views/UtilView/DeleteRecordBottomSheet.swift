//
//  DeleteRecordBottomSheet.swift
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

struct DeleteRecordBottomSheet: View {
  @Environment(\.dismiss) var dismiss
  @Dependency(\.calendarClient) var calendarClient
  
  @Binding var runDetail: RunDetail
  @Binding var isPresented: Bool
  @Binding var snackBarItem: String
  let popAction: (() -> Void)?
  
  var body: some View {
    VStack(spacing: 32) {
      VStack(spacing: 10) {
        Text("운동 기록을 삭제할까요?")
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("삭제된 기록은 다시 복구할 수 없어요!")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      
      HStack(spacing: 10) {
        Button {
          deleteRun()
        } label: {
          PrimaryActionLabel(
            text: "삭제",
            foregroundColor: Color(R.color.white_FFFFFF),
            backgroundColor: Color(R.color.error_FC5555)
          )
        }
        
        Button {
          isPresented = false
        } label: {
          PrimaryActionLabel(
            text: "아니요",
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
  }
  
  private func deleteRun() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.deleteRun(token: token, runID: runDetail.runId)
        AppAnalytics.shared.log(.recordDelete)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
          withAnimation {
            snackBarItem = "운동 기록 삭제 완료!"
          }
        }
        if let popAction {
          popAction()
        } else {
          dismiss()
        }
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
