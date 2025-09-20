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
    if exerciseManager.isRunning {
      WatchExerciseView(exerciseManager: exerciseManager)
    } else {
      VStack(spacing: 20) {
        Image("splashLogo")
          .resizable()
          .scaledToFit()
          .frame(maxWidth: .infinity)
          .padding()
        
        Button {
          exerciseManager.start()
        } label: {
          Text("시작")
            .giantsFont(size: 24, weight: .regular, lineHeight: 28)
            .foregroundStyle(Color("Greyscale_01_171717"))
        }
        .frame(width: 100, height: 100)
        .background(Color("Primary_01_D7FE63"))
        .clipShape(.rect(cornerRadius: 4))
      }
    }
  }
}
