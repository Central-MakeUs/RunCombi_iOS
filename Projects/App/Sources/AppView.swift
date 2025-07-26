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
import FeatureSignUp
import ResourceKit
import SharedUtility

struct AppView: View {
  @StateObject var userManager = UserManager()
  @State private var isSplashPresented = true
  
  var body: some View {
    if isSplashPresented {
      SplashView(isSplashPresented: $isSplashPresented)
        .environmentObject(userManager)
    } else {
      if userManager.isLoggedIn {
        MainView(startTab: userManager.petList.count == 2 ? .myPage : .exercise)
          .environmentObject(userManager)
      } else {
        if userManager.isSigning {
          SignUpRootView(isAgreementChecked: userManager.isAgreementChecked)
        } else {
          LoginView()
            .environmentObject(userManager)
        }
      }
    }
  }
}

#Preview {
  AppView()
}
