//
//  AlarmView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 8/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct AlarmView: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    VStack(spacing: 16) {
      ZStack {
        HStack {
          Button {
            dismiss()
          } label: {
            Image(R.image.backButton)
          }
          Spacer()
        }
        
        HStack {
          Spacer()
          Text("알림")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
            .foregroundStyle(Color(R.color.white_FFFFFF))
          Spacer()
        }
      }
      .padding(.top, 16)
      
      Spacer()
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
    
  }
}

#Preview {
  AlarmView()
}
