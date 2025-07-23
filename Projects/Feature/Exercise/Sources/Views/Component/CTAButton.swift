//
//  CTAButton.swift
//  FeatureExercise
//
//  Created by Groonui on 7/23/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

struct CTAButton: View {
  var title: String = ""
  var image: Image? = nil
  var foregroundColor: Color = Color(R.color.greyscale_01_171717)
  let backgroundColor: Color
  let action: () -> Void
  
  var longPressAction: (() -> Void)? = nil

  var body: some View {
    Button {
      withAnimation {
        action()
      }
    } label: {
      Group {
        if title.isEmpty {
          image
        } else {
          Text(title)
            .giantsFont(size: 24, weight: .regular, lineHeight: 28)
            .foregroundStyle(foregroundColor)
        }
      }
      .frame(width: 100, height: 100)
      .background(backgroundColor)
      .clipShape(.rect(cornerRadius: 4))
    }
    .onLongPressGesture(minimumDuration: 1) {
      longPressAction?()
    }
  }
}
