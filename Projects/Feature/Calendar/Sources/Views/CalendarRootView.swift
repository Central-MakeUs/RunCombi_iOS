//
//  CalendarRootView.swift
//  FeatureRecord
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct CalendarRootView: View {
  @Binding var snackBarItem: String
  
  public init(snackBarItem: Binding<String>) {
    self._snackBarItem = snackBarItem
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      ScrollView {
        CalendarView(snackBarItem: $snackBarItem)
      }
      .scrollIndicators(.never)
    }
  }
}
