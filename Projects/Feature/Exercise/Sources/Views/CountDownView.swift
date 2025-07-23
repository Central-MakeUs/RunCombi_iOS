//
//  CountDownView.swift
//  FeatureExercise
//
//  Created by Groonui on 7/22/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Lottie
import ResourceKit
import UserInterface

struct CountDownView: View {
  @State private var currentCount = 3
  @State private var scale: CGFloat = 2
  
  @Binding var isPresented: Bool
  
  var body: some View {
    ZStack {
      if let url = R.file.countDownJson() {
        LottieView(animation: .filepath(url.path))
          .looping()
          .frame(maxWidth: .infinity)
          .aspectRatio(1, contentMode: .fit)
          .padding(.horizontal, 70)
      }
      
      // 스케일 애니메이션이 적용된 카운트 텍스트
      Text(" \(currentCount == 0 ? 1 : currentCount)")
        .giantsFont(size: 96, weight: .bold, lineHeight: 110)
        .modifier(CenteredShearEffect(angle: .degrees(-15)))
        .foregroundStyle(Color(R.color.white_FFFFFF))
        .scaleEffect(scale)
    }
    .task {
      try? await Task.sleep(nanoseconds: 200_000_000)
      withAnimation(.easeOut(duration: 0.7)) {
        scale = 1.0
      }
      try? await Task.sleep(nanoseconds: 1_000_000_000)
      currentCount -= 1
      scale = 2.0
      withAnimation(.easeOut(duration: 0.7)) {
        scale = 1.0
      }
      try? await Task.sleep(nanoseconds: 1_000_000_000)
      currentCount -= 1
      scale = 2.0
      withAnimation(.easeOut(duration: 0.7)) {
        scale = 1.0
      }
      try? await Task.sleep(nanoseconds: 1_000_000_000)
      withAnimation {
        isPresented = false
      }
    }
  }
}
