//
//  MapOverlayView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/17/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import ResourceKit
import SharedUtility
import UserInterface

struct MapOverlayView: View {
  @EnvironmentObject var userManager: UserManager
  @ObservedObject var viewModel: ExerciseViewModel
  
  var body: some View {
    VStack {
      VStack(spacing: 47) {
        HStack(spacing: 10) {
          Image(R.image.location)
          Text(viewModel.state.localityString)
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_06_999999))
        }
        .padding(.top, 15)
        
        VStack(spacing: 25) {
          Text("함께 운동할 콤비 선택")
            .giantsFont(size: 18, weight: .regular, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
          
          HStack(spacing: .zero) {
            Image(R.image.exercisePerson)
              .overlay(alignment: .leading) {
                if let profileImgURL = URL(string: userManager.member.profileImgUrl) {
                  KFImage(profileImgURL)
                    .resizable()
                    .frame(width: 57, height: 57)
                    .clipShape(DiagonalCutShape(cutSize: CGSize(width: 7, height: 11)))
                    .clipShape(.rect(cornerRadius: 2))
                    .padding(.leading, 6)
                }
              }
            Image(R.image.exerciseDog1)
          }
          
          Text("초코와 함께!")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.primary_01_D7FE63))
        }
      }
      
      Spacer()
      NavigationLink(value: "ExerciseSettingView") {
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

/// 특정 모서리(Top-Right, Bottom-Left)만 사선으로 잘라내는 Shape
struct DiagonalCutShape: Shape {
  /// cutSize.width  = 가로로 잘려나갈 길이
  /// cutSize.height = 세로로 잘려나갈 길이
  var cutSize: CGSize
  
  func path(in rect: CGRect) -> Path {
    let dx = cutSize.width
    let dy = cutSize.height
    
    var path = Path()
    // 시작 (좌측 상단)
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    // Top edge → Top-Right 컷 시작
    path.addLine(to: CGPoint(x: rect.maxX - dx, y: rect.minY))
    // Right edge → Top-Right 컷 끝
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + dy))
    // 우측 아래 모서리
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    // Bottom edge → Bottom-Left 컷 시작
    path.addLine(to: CGPoint(x: rect.minX + dx, y: rect.maxY))
    // Left edge → Bottom-Left 컷 끝
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - dy))
    // 닫기
    path.closeSubpath()
    return path
  }
}
