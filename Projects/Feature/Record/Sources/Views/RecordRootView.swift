//
//  RecordRootView.swift
//  FeatureRecord
//
//  Created by Groonui on 7/28/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct RecordRootView: View {
  
  public init() {}
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 16) {
        RecordInfoSection()
        Spacer()
      }
      .padding(.horizontal, 20)
      .padding(.top, 36)
    }
  }
}

#Preview {
  RecordRootView()
}
