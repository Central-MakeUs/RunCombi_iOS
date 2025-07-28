//
//  MainView.swift
//  FeatureMain
//
//  Created by 임경빈 on 6/25/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainLogin
import FeatureCalendar
import FeatureExercise
import FeatureMyPage
import LocalizableStringManager
import ResourceKit
import SharedUtility
import UserInterface

public struct MainView: View {
  @EnvironmentObject var userManager: UserManager
  @Dependency(\.loginClient) var loginClient
  @StateObject private var exerciseViewModel = ExerciseViewModel()
  @State private var currentTab: MainTab
  @State private var path = NavigationPath()
  @State private var snackBarItem = ""

  public init(startTab: MainTab = .exercise) {
    currentTab = .calendar
  }
  
  public var body: some View {
    NavigationStack(path: $path) {
      ZStack {
        TabView(selection: $currentTab) {
          RecordRootView()
            .tag(MainTab.calendar)
          
          ExerciseRootView(path: $path, viewModel: exerciseViewModel)
            .padding(.bottom, 21)
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
    .onChange(of: userManager.shouldRefresh) {
      if userManager.shouldRefresh {
        refreshUserManager()
      }
    }
  }
  
  private func refreshUserManager() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        let memberDetail = try await loginClient.getMemberDetail(token: token)
        userManager.setUserManager(to: memberDetail)
      } catch {
        Logger.e("\(error)")
      }
      userManager.shouldRefresh = false
    }
  }
}
