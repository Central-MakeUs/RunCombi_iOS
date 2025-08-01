//
//  ExerciseKcalSection.swift
//  FeatureExercise
//
//  Created by Groonui on 7/24/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import ResourceKit
import SharedUtility

struct ExerciseKcalSection: View {
  @ObservedObject var viewModel: ExerciseViewModel
  @EnvironmentObject var userManager: UserManager
  
  var body: some View {
    if viewModel.state.exerciseStatus == .exercise || viewModel.state.exerciseStatus == .pause {
      HStack(spacing: .zero) {
        ZStack {
          Image(R.image.background1)
          
          VStack(spacing: 4) {
            Group {
              if let profileImgURL = URL(string: userManager.member.profileImgUrl) {
                KFImage(profileImgURL)
                  .resizable()
                  .frame(width: 45, height: 45)
              } else {
                Image(R.image.person)
                  .resizable()
                  .frame(width: 45, height: 45)
              }
            }
            .background {
              RoundedRectangle(cornerRadius: 2)
                .fill(
                  LinearGradient(
                    gradient: Gradient(colors: [
                      Color(R.color.white_FFFFFF),
                      Color(R.color.primary_02_E8FFA3)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                  )
                )
                .frame(width: 48, height: 48)
            }
            
            Text(userManager.member.nickname)
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
              .padding(.top, 4)
            
            HStack(spacing: 3.5) {
              Text("\(viewModel.state.exercisePersonKcal)")
                .giantsFont(size: 24, weight: .regular, lineHeight: 28)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
              Text("kcal")
                .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                .padding(.top, 3)
            }
          }
          .padding(.trailing, 10)
        }
        
        ZStack {
          Image(R.image.background2)
          
          VStack(spacing: 4) {
            Image(R.image.dog)
              .resizable()
              .frame(width: 45, height: 45)
              .background {
                RoundedRectangle(cornerRadius: 2)
                  .fill(Color(R.color.primary_02_E8FFA3))
                  .frame(width: 48, height: 48)
              }
            Text("초코")
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
              .padding(.top, 4)
            
            HStack(spacing: 3.5) {
              Text("\(viewModel.state.exerciseDogKcal)")
                .giantsFont(size: 24, weight: .regular, lineHeight: 28)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
              Text("kcal")
                .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
                .padding(.top, 3)
            }
          }
          .padding(.leading, 10)
        }
      }
    }
  }
}
