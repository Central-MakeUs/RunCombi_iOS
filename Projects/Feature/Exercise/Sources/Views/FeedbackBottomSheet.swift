//
//  FeedbackBottomSheet.swift
//  FeatureExercise
//
//  Created by Claude on 3/24/26.
//  Copyright © 2026 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainMyPage
import ResourceKit
import SharedUtility
import UserInterface

struct FeedbackBottomSheet: View {
  @Dependency(\.myPageClient) var myPageClient
  @Binding var isPresented: Bool
  @State private var typedFeedbackText = ""
  @FocusState private var isFocused: Bool

  var body: some View {
    VStack(spacing: 24) {
      VStack(spacing: 10) {
        Text("콤비와의 운동, 어떠셨나요?")
          .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
          .foregroundStyle(Color(R.color.white_FFFFFF))
          .frame(maxWidth: .infinity, alignment: .leading)

        Text("작은 의견도 런콤비에겐 큰 힘이 돼요!")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
          .frame(maxWidth: .infinity, alignment: .leading)
      }

      VStack(alignment: .trailing, spacing: 4) {
        TextEditor(text: $typedFeedbackText)
          .focused($isFocused)
          .disableAutocorrection(true)
          .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
          .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          .frame(height: 120)
          .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
          .scrollContentBackground(.hidden)
          .background(Color(R.color.greyscale_03_333333))
          .cornerRadius(4)
          .onChange(of: typedFeedbackText) {
            if typedFeedbackText.count > 100 {
              typedFeedbackText = String(typedFeedbackText.prefix(100))
            }
          }
          .overlay(alignment: .topLeading) {
            Text("의견을 작성해주세요")
              .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
              .foregroundStyle(typedFeedbackText.isEmpty ? Color(R.color.greyscale_04_525252) : .clear)
              .padding(.leading, 23)
              .padding(.top, 23)
          }
        HStack(spacing: .zero) {
          Text("\(typedFeedbackText.count)")
            .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          Text("/100")
            .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
            .foregroundStyle(Color(R.color.white_FFFFFF).opacity(0.32))
        }
      }

      HStack(spacing: 10) {
        Button {
          isPresented = false
        } label: {
          PrimaryActionLabel(
            text: "다음에",
            foregroundColor: Color(R.color.greyscale_08_EDEDED),
            backgroundColor: Color(R.color.greyscale_04_525252)
          )
        }

        Button {
          sendFeedback()
        } label: {
          PrimaryActionLabel(
            text: "보내기",
            foregroundColor: typedFeedbackText.isEmpty ? Color(R.color.gray_090909) : Color(R.color.greyscale_02_252525),
            backgroundColor: typedFeedbackText.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
          )
        }
        .disabled(typedFeedbackText.isEmpty)
      }
    }
    .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
    .onChange(of: isPresented) {
      if !isPresented {
        markFeedbackShown()
      }
    }
  }

  private func sendFeedback() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await myPageClient.suggestion(token: token, message: typedFeedbackText)
        let bucket = typedFeedbackText.count <= 20 ? "short" : (typedFeedbackText.count <= 60 ? "medium" : "long")
        AppAnalytics.shared.log(.feedbackSubmit(lengthBucket: bucket))
        isPresented = false
      } catch {
        Logger.e("\(error)")
      }
    }
  }

  // MARK: - 1달 간격 체크

  private static let lastFeedbackDateKey = "lastFeedbackPromptDate"

  static func shouldShowFeedback() -> Bool {
    guard let lastDate = UserDefaults.standard.object(forKey: lastFeedbackDateKey) as? Date else {
      return true
    }
    let oneMonthLater = Calendar.current.date(byAdding: .month, value: 1, to: lastDate)!
    return Date() >= oneMonthLater
  }

  private func markFeedbackShown() {
    UserDefaults.standard.set(Date(), forKey: FeedbackBottomSheet.lastFeedbackDateKey)
  }
}
