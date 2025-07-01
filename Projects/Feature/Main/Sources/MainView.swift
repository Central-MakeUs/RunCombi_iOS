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
import UserInterface

public struct MainView: View {
  public init() {}
  
  public var body: some View {
    ZStack {
      Color(R.color.primary_01_D7FE63)
      VStack {
        Text("heading1\nheading1")
          .customFont(.heading1)
        Text("title2\ntitle2")
          .customFont(.title2)
        Text("title3\ntitle3")
          .customFont(.title3)
        Text("title4\ntitle4")
          .customFont(.title4)
        Text("body1\nbody1")
          .customFont(.body1)
        Text("body2\nbody2")
          .customFont(.body2)
        Text("body3\nbody3")
          .customFont(.body3)
        Text(String(key: "Test"))
      }
    }
  }
}

#Preview {
  MainView()
}
