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
  @State private var currentTab: MainTab = .exercise
  
  public init() {}
  
  public var body: some View {
    ZStack {
      TabView(selection: $currentTab) {
        Text("Calendar View")
        .tag(MainTab.calendar)
        
        Text("Exercise View")
          .tag(MainTab.exercise)
        
        Text("MyPage View")
          .tag(MainTab.myPage)
      }
      .toolbar(.hidden, for: .tabBar)
      
      CustomTabBar(currentTab: $currentTab)
//        .opacity(appEnvironment.isTabPresented ? 1 : 0)
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
}
