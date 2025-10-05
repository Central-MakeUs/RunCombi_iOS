//
//  WatchSelectCombiView.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 10/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainLogin
import SharedUtility

struct WatchSelectCombiView: View {
  @Dependency(\.loginClient) var loginClient
  @ObservedObject var exerciseManager: ExerciseManager
  
  @State private var memberDetail: MemberDetail = .empty
  
  var body: some View {
    ScrollView {
      VStack(spacing: 12) {
        Text("함께 운동할 콤비를 선택해주세요!")
          .pretendardFont(size: 16, weight: .semiBold, lineHeight: 24)
          .foregroundStyle(.white)
        
        VStack(spacing: 12) {
          ForEach(memberDetail.petList, id: \.self) { pet in
            Button {
              if let index = exerciseManager.selectedPets.firstIndex(of: pet) {
                exerciseManager.selectedPets.remove(at: index)
              } else {
                exerciseManager.selectedPets.append(pet)
              }
            } label: {
              Text(pet.name)
                .pretendardFont(size: 14, weight: .semiBold, lineHeight: 14)
                .foregroundStyle(isSelected(pet) ? Color.black : Color("Greyscale_08_EDEDED"))
                .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
                .frame(maxWidth: .infinity)
                .background(
                  isSelected(pet)
                  ? Color("Primary_01_D7FE63")
                  : Color("Greyscale_04_525252")
                )
                .clipShape(.rect(cornerRadius: 20))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 10)
          }
          
          Button {
            if !exerciseManager.selectedPets.isEmpty {
              exerciseManager.isCombiSelecting = false
              exerciseManager.isStyleSetting = true
            }
          } label: {
            Text("선택 완료")
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 14)
              .foregroundStyle(Color("Greyscale_08_EDEDED"))
              .padding(EdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12))
              .frame(maxWidth: .infinity)
              .background(Color("Greyscale_04_525252"))
              .clipShape(.rect(cornerRadius: 20))
          }
          .buttonStyle(.plain)
          .padding(.horizontal, 10)
        }
      }
      .padding(.horizontal, 20)
    }
    .task {
      do {
        memberDetail = try await loginClient.getMemberDetail(token: WatchSessionManagerInWatch.shared.token.ifNil(then: ""), isWatch: true)
      } catch {
        Logger.e("\(error)")
      }
    }
  }
  
  private func isSelected(_ pet: Pet) -> Bool {
    exerciseManager.selectedPets.contains(pet)
  }
}
