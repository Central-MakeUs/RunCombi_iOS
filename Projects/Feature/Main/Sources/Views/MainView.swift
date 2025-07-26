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
  @StateObject private var exerciseViewModel = ExerciseViewModel()
  @State private var currentTab: MainTab
  @State private var path = NavigationPath()
  @State private var snackBarItem = ""

  public init(startTab: MainTab = .exercise) {
    currentTab = startTab
  }
  
  public var body: some View {
    NavigationStack(path: $path) {
      ZStack {
        TabView(selection: $currentTab) {
          Color(R.color.greyscale_01_171717)
            .ignoresSafeArea()
            .tag(MainTab.calendar)
          
          ExerciseRootView(path: $path, viewModel: exerciseViewModel)
            .padding(.bottom, 22)
            .tag(MainTab.exercise)
          
          MyPageView(path: $path, snackBarItem: $snackBarItem)
            .padding(.bottom, 20)
            .tag(MainTab.myPage)
        }
        .toolbar(.hidden, for: .tabBar)
        
        CustomTabBar(currentTab: $currentTab)
//                .opacity(appEnvironment.isTabPresented ? 1 : 0) // 탭 바 숨기기
      }
      .navigationDestination(for: String.self) { destination in
        switch destination {
        case "ExerciseSettingView":
          ExerciseSettingView(viewModel: exerciseViewModel)
        case "ExerciseView":
          ExerciseView(viewModel: exerciseViewModel)
        case "SettingView":
          SettingView(path: $path, snackBarItem: $snackBarItem)
        case "InquiryView":
          InquiryView(path: $path, snackBarItem: $snackBarItem)
        default:
          EmptyView()
        }
      }
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
  }
}
