//
//  DetailEvaluationSection.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainCalendar
import Dependencies
import ResourceKit
import SharedUtility

struct DetailEvaluationSection: View {
  @Dependency(\.calendarClient) var calendarClient
  @State private var selectedEvaluation: ExerciseEvaluation = .none
  @Binding var runDetail: RunDetail
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      // 섹션 제목
      Text("운동 평가")
        .pretendardFont(size: 13, weight: .medium, lineHeight: 26)
        .foregroundStyle(Color(R.color.gray_C0C0C0))
      
      // 평가 항목 나열
      HStack(spacing: 12) {
        ForEach(ExerciseEvaluation.allCases) { evaluation in
          if evaluation != .none {
            Button {
              setRunEvaluating(to: evaluation)
            } label: {
              VStack(spacing: 5) {
                if evaluation == selectedEvaluation {
                  evaluation.selectedImage
                } else {
                  evaluation.image
                }
                
                Text(evaluation.rawValue)
                  .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
                  .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
              }
            }
          }
        }
      }
    }
    .onChange(of: runDetail) {
      selectedEvaluation = ExerciseEvaluation.convertExerciseEvaluation(runDetail.runEvaluating)
    }
  }
  
  private func setRunEvaluating(to evaluation: ExerciseEvaluation) {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await calendarClient.setRunEvaluating(
          token: token,
          runID: runDetail.runId,
          evaluation: evaluation.serverValue
        )
        selectedEvaluation = evaluation
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
