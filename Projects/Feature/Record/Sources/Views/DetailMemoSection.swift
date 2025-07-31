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
  
  @State private var memoText = ""
  @State private var isMemoViewPresented = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      HStack {
        Text("메모")
          .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
          .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
        
        Spacer()
        
        Button {
          isMemoViewPresented = true
        } label: {
          if memoText.isEmpty {
            Image(R.image.plus)
              .resizable()
              .frame(width: 24, height: 24)
          } else {
            Image(R.image.pencil)
          }
        }
      }
      
      Text(memoText)
        .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
        .foregroundColor(Color(R.color.greyscale_07_B3B3B3))
    }
    .onAppear {
      memoText = runDetail.memo
    }
    .fullScreenCover(isPresented: $isMemoViewPresented) {
      MemoView(memoText: $memoText)
    }
  }
}
