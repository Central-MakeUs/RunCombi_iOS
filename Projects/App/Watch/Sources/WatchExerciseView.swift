//
//  ExerciseView.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 9/20/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import SharedUtility

struct WatchExerciseView: View {
  @ObservedObject var exerciseManager: ExerciseManager
  
  var body: some View {
    VStack(spacing: 12) {
      // 운동 시간
      Text(exerciseManager.elapsedTimeString)
        .font(.title2)
        .monospacedDigit()
      
      // 거리
      Text(String(format: "%.2f km", exerciseManager.distance / 1000))
        .font(.headline)
      
      // 시작 / 정지 버튼
      Button {
        exerciseManager.stop()
      } label: {
        Image("pause")
      }
      .frame(width: 100, height: 100)
      .background(Color("Greyscale_02_252525"))
      .clipShape(.rect(cornerRadius: 4))
      .buttonStyle(.plain)
    }
    .padding()
  }
}
