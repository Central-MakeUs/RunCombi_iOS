//
//  DetailEvaluationSection.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct DetailEvaluationSection: View {
  @State private var selectedEvaluation: ExerciseEvaluation = .none
  
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
              selectedEvaluation = evaluation
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
  }
}
