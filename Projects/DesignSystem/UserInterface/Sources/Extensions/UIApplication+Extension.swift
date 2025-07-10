//
//  UIApplication+Extension.swift
//  UserInterface
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public extension UIApplication {
  func closeKeyboard() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
