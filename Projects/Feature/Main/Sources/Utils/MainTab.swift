//
//  MainTab.swift
//  FeatureMain
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import ResourceKit

public enum MainTab: CaseIterable {
  case calendar
  case exercise
  case myPage
}

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
