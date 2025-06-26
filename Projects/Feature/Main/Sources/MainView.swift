//
//  MainView.swift
//  FeatureMain
//
//  Created by 임경빈 on 6/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import LocalizableStringManager
import ResourceKit

public struct MainView: View {
  public init() {}
  
  public var body: some View {
    ZStack {
      Color(R.color.red_FF0000)
      Text(String(key: "Test"))
//      Text("Main View \(String(key: "Test"))")
    }
  }
}

#Preview {
  MainView()
}
