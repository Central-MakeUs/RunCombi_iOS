//
//  MapOverlayView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/17/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct MapOverlayView: View {
  @Binding var localityString: String
  
  var body: some View {
    VStack {
      HStack(spacing: 10) {
        Image(R.image.location)
        Text(localityString)
          .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
      }
      .padding(.top, 15)
      
      Spacer()
      Button {
        // TODO: - 운동 설정 화면으로 이동
      } label: {
        Text("운동")
          .giantsFont(size: 24, weight: .regular, lineHeight: 28)
          .foregroundStyle(Color(R.color.greyscale_02_252525))
          .frame(width: 100, height: 100)
          .background(Color(R.color.primary_01_D7FE63))
          .clipShape(.rect(cornerRadius: 4))
      }
      .padding(.bottom, 50)
    }
    .frame(maxWidth: .infinity)
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(R.color.greyscale_01_171717).opacity(0.99),
          Color(R.color.black_000000).opacity(0),
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .frame(height: 350)
      , alignment: .top
    )
  }
}
