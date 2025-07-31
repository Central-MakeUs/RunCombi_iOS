//
//  DetailMemoSection.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainCalendar
import ResourceKit

struct DetailMemoSection: View {
  let runDetail: RunDetail
  
  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Text("메모")
          .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
          .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
        
        Spacer()
        
        Button {
          // TODO: - 메모 추가
        } label: {
          runDetail.memo.isEmpty ? Image(R.image.plus) : Image(R.image.pencil)
        }
      }
      
      Text(runDetail.memo)
        .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
        .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
    }
  }
}
