//
//  MainView.swift
//  FeatureMain
//
//  Created by 임경빈 on 6/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import FeatureExercise
import FeatureMyPage
import LocalizableStringManager
import ResourceKit
import UserInterface

public struct MainView: View {
  @State private var currentTab: MainTab
  
  public init(startTab: MainTab = .exercise) {
    currentTab = startTab
  }
  
  public var body: some View {
    NavigationStack {
      ZStack {
        TabView(selection: $currentTab) {
          Text("Calendar View")
            .tag(MainTab.calendar)
          
          ExerciseView()
            .padding(.bottom, 22)
            .tag(MainTab.exercise)
          
          MyPageView()
            .padding(.bottom, 22)
            .tag(MainTab.myPage)
        }
        .toolbar(.hidden, for: .tabBar)
        
        CustomTabBar(currentTab: $currentTab)
        //        .opacity(appEnvironment.isTabPresented ? 1 : 0)
      }
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
}
