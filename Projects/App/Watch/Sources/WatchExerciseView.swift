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
        .giantsFont(size: 24, weight: .regular, lineHeight: 24)
        .foregroundStyle(Color.white)
        .modifier(CenteredShearEffect(angle: .degrees(-12)))
      
      // 거리
      HStack(alignment: .bottom, spacing: 2) {
        Text(exerciseManager.distance.toKilometersString)
          .giantsFont(size: 16, weight: .regular, lineHeight: 16)
          .foregroundStyle(Color("Greyscale_06_999999"))
          .modifier(CenteredShearEffect(angle: .degrees(-12)))
        Text("km")
          .giantsFont(size: 12, weight: .regular, lineHeight: 14)
          .foregroundStyle(Color("Greyscale_06_999999"))
      }
      
      // 시작 / 정지 버튼
      Button {
        exerciseManager.stop()
      } label: {
        Image("stop")
          .renderingMode(.template)
          .foregroundStyle(.white)
          .frame(width: 80, height: 80)
          .background(Color("Greyscale_02_252525"))
          .clipShape(.rect(cornerRadius: 4))
      }
      .buttonStyle(.plain)
      
    }
    .padding()
  }
}
