//
//  LoginView.swift
//  FeatureLogin
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import LocalizableStringManager
import ResourceKit
import UserInterface

public struct LoginView: View {
  
  public init() {}
  
  public var body: some View {
    VStack {
      Spacer()
      
      Text(String(key: "Login.Title"))
        .font(.pretendard(size: 40, weight: .extraBold))
        .foregroundStyle(Color(R.color.primary_01_D7FE63))
      
      Spacer()
      
      VStack(spacing: 14) {
        Button {
          // TODO: = 카카오 Login
        } label: {
          Text("카카오로 시작하기")
        }
        
        Button {
          // TODO: = Apple Login
        } label: {
          Text("Apple로 시작하기")
        }
      }
    }
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
  }
}

#Preview {
  LoginView()
}
