//
//  SwiftUIView.swift
//  RunCombiWatchExtension
//
//  Created by Groonui on 9/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

@main
struct RunCombiWatchApp: App {
  init() {
    setFont()
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
  
  private func setFont() {
    FontKit.registerPretendardFonts()
    FontKit.registerGiantsFonts()
  }
}
