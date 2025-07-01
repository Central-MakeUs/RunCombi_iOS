//
//  RunCombiApp.swift
//  RunCombi
//
//  Created by 임경빈 on 6/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import FeatureMain
import UserInterface

@main
struct RunCombiApp: App {
  init() {
    FontKit.registerPretendardFonts()
  }
  
  var body: some Scene {
    WindowGroup {
      MainView()
    }
  }
}
