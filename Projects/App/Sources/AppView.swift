//
//  AppView.swift
//  RunCombi
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import FeatureLogin
import FeatureMain
import FeatureSplash
import ResourceKit

struct AppView: View {
  @State private var isSplashPresented = true
  @State private var isLoggedIn: Bool = false
  
  var body: some View {
    if isSplashPresented {
      SplashView(isSplashPresented: $isSplashPresented)
    } else {
      if isLoggedIn {
        MainView()
      } else {
        LoginView()
      }
    }
  }
}

#Preview {
  AppView()
}
