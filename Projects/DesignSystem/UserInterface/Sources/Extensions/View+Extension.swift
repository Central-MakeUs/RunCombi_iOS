//
//  View+Extension.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import SharedUtility

public extension View {
  var firstWindow: UIWindow? {
    UIApplication.shared.windows.first
  }
  
  func getSafeArea() -> UIEdgeInsets {
    return (firstWindow?.safeAreaInsets).ifNil(then: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
  }
  
  func getPaddingForSafeArea(defaultPadding: CGFloat = 16, noPadding: CGFloat = 0) -> CGFloat {
    return getSafeArea().bottom == 0 ? defaultPadding : noPadding
  }
  
  func bottomSheet<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
    overlay(BottomSheetView(isPresented: isPresented, content: content))
  }
  
  func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
    clipShape( RoundedCorners(radius: radius, corners: corners) )
  }
}
