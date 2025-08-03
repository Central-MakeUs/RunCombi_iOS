//
//  CustomTabBar.swift
//  FeatureMain
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility

extension MainTab {
  var icon: Image {
    switch self {
    case .calendar:
      Image(R.image.calendar)
    case .exercise:
      Image(R.image.exercise)
    case .myPage:
      Image(R.image.myPage)
    }
  }
  
  var selectedIcon: Image {
    switch self {
    case .calendar:
      Image(R.image.selectedCalendar)
    case .exercise:
      Image(R.image.selectedExercise)
    case .myPage:
      Image(R.image.selectedMyPage)
    }
  }
}

struct CustomTabBar: View {
  @Binding var currentTab: MainTab
  
  var body: some View {
    VStack {
      Spacer()
      HStack(spacing: 0) {
        Spacer()
        
        ForEach(MainTab.allCases, id: \.self) { tab in
          TabItem(tab: tab, currentTab: $currentTab)
          Spacer()
        }
      }
      .padding(.vertical, 19)
      .frame(maxWidth: .infinity)
      .background(Color(R.color.greyscale_01_171717))
    }
  }
}

struct TabItem: View {
  let tab: MainTab
  @Binding var currentTab: MainTab
  
  var body: some View {
    Button {
      currentTab = tab
    } label: {
      currentTab == tab ? tab.selectedIcon : tab.icon
    }
  }
}
