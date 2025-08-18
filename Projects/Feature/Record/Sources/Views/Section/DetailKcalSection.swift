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
              .scaledToFill()
              .frame(width: 47, height: 47)
              .clipShape(.rect(cornerRadius: 2))
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
                .resizable()
                .frame(width: 53, height: 53)
            }
          }
          
          Text(name)
            .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
        }
        
        VStack(alignment: .leading, spacing: 6) {
          Text(isPerson ? getBurnedFoodInfo(for: cal) : getFeedDescription(for: cal))
            .giantsFont(size: 18, weight: .regular, lineHeight: 26)
            .foregroundColor(Color(R.color.greyscale_08_EDEDED))
            .modifier(CenteredShearEffect(angle: .degrees(-12)))
          
          HStack(spacing: 12) {
            Image(R.image.fire)
            HStack(alignment: .bottom, spacing: 4) {
              Text("\(cal)")
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
    
    private func getBurnedFoodInfo(for calories: Int) -> String {
      switch calories {
      case 0..<50:
        "조금 움직였어요!"
      case 50..<100:
        "막대사탕 하나 태웠어요!"
      case 100..<150:
        "소프트콘 하나 태웠어요!"
      case 150..<200:
        "핫바 하나 태웠어요!"
      case 200..<250:
        "도넛 하나 태웠어요!"
      case 250..<300:
        "츄러스 하나 태웠어요!"
      case 300..<350:
        "밥 한 공기 태웠어요!"
      case 350..<400:
        "감자튀김 한 세트 태웠어요!"
      case 400..<450:
        "김밥 한 줄 태웠어요!"
      case 450..<500:
        "피자 두 조각 태웠어요!"
      case 500..<600:
        "라면 한 봉지 태웠어요!"
      case 600..<700:
        "파스타 한 접시 태웠어요!"
      case 700..<800:
        "치킨 세 조각 태웠어요!"
      case 800..<900:
        "햄버거 한 세트 태웠어요!"
      case 900..<1000:
        "라면 두 봉지 태웠어요!"
      case 1000..<1200:
        "과자 두 봉지 태웠어요!"
      case 1200..<1500:
        "케이크 한 판 태웠어요!"
      case 1500..<2000:
        "햄버거 두 세트 태웠어요!"
      case 2000..<2500:
        "치킨 한 마리 태웠어요!"
      default:
        "피자 한 판 태웠어요!"
      }
    }
    
    func getFeedDescription(for value: Int) -> String {
      switch value {
      case 0..<10:
        return "조금 움직였어요!"
      case 10..<20:
        return "사료 10알 태웠어요!"
      case 20..<30:
        return "사료 15알 태웠어요!"
      case 30..<40:
        return "사료 20알 태웠어요!"
      case 40..<50:
        return "사료 25알 태웠어요!"
      case 50..<60:
        return "사료 30알 태웠어요!"
      case 60..<70:
        return "사료 35알 태웠어요!"
      case 70..<80:
        return "사료 40알 태웠어요!"
      case 80..<90:
        return "사료 50알 태웠어요!"
      case 90..<100:
        return "사료 55알 태웠어요!"
      case 100..<120:
        return "사료 60알 태웠어요!"
      case 120..<140:
        return "사료 70알 태웠어요!"
      case 140..<160:
        return "사료 80알 태웠어요!"
      case 160..<180:
        return "사료 100알 태웠어요!"
      case 180..<200:
        return "사료 110알 태웠어요!"
      case 200..<250:
        return "사료 130알 태웠어요!"
      case 250..<300:
        return "사료 160알 태웠어요!"
      case 300..<350:
        return "사료 180알 태웠어요!"
      case 350..<400:
        return "사료 200알 태웠어요!"
      default:
        return "사료 한 줌 태웠어요!"
      }
    }
  }
}
