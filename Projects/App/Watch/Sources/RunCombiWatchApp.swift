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
    WatchSessionManagerInWatch.shared.activateSession()
  }
  
  var body: some Scene {
    WindowGroup {
      WatchStartView()
    }
  }
  
  private func setFont() {
    FontKit.registerPretendardFonts()
    FontKit.registerGiantsFonts()
  }
}
