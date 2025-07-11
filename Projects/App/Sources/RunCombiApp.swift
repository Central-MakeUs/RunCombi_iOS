//
//  RunCombiApp.swift
//  RunCombi
//
//  Created by 임경빈 on 6/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import GoogleMaps
import UserInterface

@main
struct RunCombiApp: App {
  
  init() {
    FontKit.registerPretendardFonts()
    GMSServices.provideAPIKey("")
  }
  
  var body: some Scene {
    WindowGroup {
      AppView()
    }
  }
}
