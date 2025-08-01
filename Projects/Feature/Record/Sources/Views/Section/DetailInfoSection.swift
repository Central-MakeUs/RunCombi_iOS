//
//  DetailInfoSection.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainCalendar
import ResourceKit
import UserInterface

struct DetailInfoSection: View {
  @Binding var runDetail: RunDetail
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text("함께 운동한 시간")
        .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
        .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
      HStack(alignment: .bottom) {
        HStack(alignment: .bottom, spacing: 0) {
          Text("\(runDetail.runTime / 60) ")
            .giantsFont(size: 36, weight: .regular, lineHeight: 30)
            .foregroundColor(Color(R.color.ff_F4F4F4))
            .modifier(CenteredShearEffect(angle: .degrees(-12)))
          Text("min")
            .giantsFont(size: 20, weight: .regular, lineHeight: 20)
            .foregroundColor(Color(R.color.ff_F4F4F4))
            .modifier(CenteredShearEffect(angle: .degrees(-12)))
        }
        
        Spacer()
        
        HStack(alignment: .bottom, spacing: 0) {
          Text("\(String(format: "%.2f", runDetail.runDistance)) ")
            .giantsFont(size: 22, weight: .regular, lineHeight: 22)
            .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
            .modifier(CenteredShearEffect(angle: .degrees(-12)))
          Text("km")
            .giantsFont(size: 16, weight: .regular, lineHeight: 20)
            .foregroundColor(Color(R.color.greyscale_06_999999))
            .modifier(CenteredShearEffect(angle: .degrees(-12)))
        }
      }
    }
  }
}
