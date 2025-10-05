//
//  WatchExerciseSettingView.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 10/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import SharedUtility

struct WatchExerciseSettingView: View {
  @Environment(\.dismiss) var dismiss
  @ObservedObject var exerciseManager: ExerciseManager

  var body: some View {
    ScrollView {
      VStack(spacing: 12) {
        Text("어떤 운동을 하실 건가요?")
          .pretendardFont(size: 16, weight: .semiBold, lineHeight: 24)
          .foregroundStyle(.white)
        
        VStack(spacing: 12) {
          ForEach(WalkStyleType.allCases.reversed(), id: \.self) { type in
            if type != .none {
              Button {
                exerciseManager.isStyleSetting = false
                exerciseManager.selectedMemberRunStyle = type
                exerciseManager.start()
              } label: {
                Text(type.memberRunStyle)
                  .pretendardFont(size: 14, weight: .semiBold, lineHeight: 14)
                  .foregroundStyle(Color("Greyscale_08_EDEDED"))
                  .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                  .frame(maxWidth: .infinity)
                  .background(Color("Greyscale_04_525252"))
                  .clipShape(.rect(cornerRadius: 20))
              }
              .buttonStyle(.plain)
              .padding(.horizontal, 10)
  //            .disabled(isButtonDisabled)
            }
          }
        }
      }
      .padding(.horizontal, 20)
    }
  }
}
