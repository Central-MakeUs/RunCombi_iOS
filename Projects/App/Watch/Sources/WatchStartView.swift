//
//  ContentView.swift
//  RunCombiWatchExtension
//
//  Created by Groonui on 9/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

struct WatchStartView: View {
  @StateObject private var exerciseManager = ExerciseManager()
  
  var body: some View {
    if exerciseManager.isCombiSelecting {
      WatchSelectCombiView(exerciseManager: exerciseManager)
    } else if exerciseManager.isStyleSetting {
      WatchExerciseSettingView(exerciseManager: exerciseManager)
    } else if exerciseManager.isRunning {
      WatchExerciseView(exerciseManager: exerciseManager)
    } else {
      VStack(spacing: 20) {
        Image("splashLogo")
          .resizable()
          .scaledToFit()
          .frame(maxWidth: .infinity)
          .padding()
        
        Button {
          exerciseManager.checkToken()
        } label: {
          Text("시작")
            .giantsFont(size: 24, weight: .regular, lineHeight: 28)
            .foregroundStyle(Color("Greyscale_01_171717"))
            .frame(width: 80, height: 80)
            .background(Color("Primary_01_D7FE63"))
            .clipShape(.rect(cornerRadius: 4))
        }
        .buttonStyle(.plain)
      }
      .alert("워치 연동 안내", isPresented: $exerciseManager.isTokenAlertPresented, actions: {
        Button {
          
        } label: {
          Text("확인")
        }
      }, message: {
        Text("유저 정보를 불러오지 못했습니다\n휴대폰의 런콤비 앱 > 설정 화면에서 워치 연동을 진행해주세요")
      })
    }
  }
}
