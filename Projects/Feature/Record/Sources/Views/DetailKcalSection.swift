//
//  DetailKcalSection.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainCalendar
import Kingfisher
import ResourceKit
import UserInterface

struct DetailKcalSection: View {
  let runDetail: RunDetail
  
  var body: some View {
    VStack(spacing: 12) {
      kcalSection(
        name: runDetail.nickname,
        cal: runDetail.memberCal,
        imageURL: runDetail.profileImgUrl,
        isPerson: true
      )
      
      ForEach(runDetail.petData, id: \.self) { pet in
        kcalSection(
          name: pet.name,
          cal: pet.petCal,
          imageURL: pet.petImageUrl,
          isPerson: false
        )
      }
    }
  }
}

private extension DetailKcalSection {
  struct kcalSection: View {
    let name: String
    let cal: Int
    let imageURL: String
    let isPerson: Bool
    
    var body: some View {
      HStack(spacing: 25) {
        VStack(spacing: 4) {
          if let imageURL = URL(string: imageURL) {
            KFImage(imageURL)
              .resizable()
              .frame(width: 47, height: 47)
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
                  .frame(width: 53, height: 53)
              }
          } else {
            if isPerson {
              Image(R.image.person)
                .resizable()
                .frame(width: 47, height: 47)
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
                    .frame(width: 53, height: 53)
                }
            } else {
              Image(R.image.defaultDog)
            }
          }
          
          Text(name)
            .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
        }
        
        VStack(alignment: .leading, spacing: 6) {
          Text("소프트콘 하나 태웠어요!")
            .giantsFont(size: 18, weight: .regular, lineHeight: 26)
            .foregroundColor(Color(R.color.greyscale_08_EDEDED))
            .modifier(CenteredShearEffect(angle: .degrees(-12)))
          
          HStack(spacing: 12) {
            Image(R.image.fire)
            HStack(alignment: .bottom, spacing: 4) {
              Text("\(cal / 1000)")
                .giantsFont(size: 20, weight: .regular, lineHeight: 20)
                .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
              Text(" kcal")
                .giantsFont(size: 12, weight: .regular, lineHeight: 12)
                .foregroundColor(Color(R.color.greyscale_06_999999))
                .modifier(CenteredShearEffect(angle: .degrees(-12)))
            }
          }
          .padding(.leading, 4)
        }
        
        Spacer()
      }
      .frame(maxWidth: .infinity)
      .padding(EdgeInsets(top: 12, leading: 13, bottom: 6, trailing: 13))
      .background(Color(R.color.greyscale_02_252525))
      .clipShape(.rect(cornerRadius: 6))
    }
  }
}
