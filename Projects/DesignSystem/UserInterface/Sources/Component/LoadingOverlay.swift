//
//  LoadingOverlay.swift
//  UserInterface
//
//  Created by 임경빈 on 8/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct LoadingOverlay: View {
  private let loadingText: String
  private let interval: TimeInterval = 0.5

  public init(loadingText: String = "로딩 중") {
    self.loadingText = loadingText
  }
  
  public var body: some View {
    ZStack {
      Color.black.opacity(0.35).ignoresSafeArea()
      VStack(spacing: 12) {
        Image(R.image.completedDog)
          .resizable()
          .frame(width: 76, height: 45)
        
        TimelineView(.periodic(from: .now, by: interval)) { context in
          let step = Int(context.date.timeIntervalSinceReferenceDate / interval) % 4
          Text("\(loadingText)\(String(repeating: ".", count: step))")
        }
        .frame(width: 60, alignment: .leading)
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.white_FFFFFF))
      }
      .padding(20)
      .background(Color(R.color.greyscale_02_252525))
      .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
      .shadow(radius: 12)
    }
    .transition(.opacity)
  }
}
