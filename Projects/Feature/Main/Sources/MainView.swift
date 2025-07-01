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
      Color(R.color.primary_01_D7FE63)
      Text(String(key: "Test"))
    }
  }
}

#Preview {
  MainView()
}
