//
//  ContentView.swift
//  RunCombiWatchExtension
//
//  Created by Groonui on 9/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @State private var count = 0
  
  var body: some View {
    VStack(spacing: 8) {
      Text("RunCombi Watch")
        .font(.headline)
      
      Text("Count: \(count)")
        .font(.title3)
      
      Button("Tap") {
        count += 1
      }
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
