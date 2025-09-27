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
  
  func hideKeyboard() {
    guard let window = windows.first else { return }
    let tapRecognizer = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
    tapRecognizer.cancelsTouchesInView = false
    tapRecognizer.delegate = self
    window.addGestureRecognizer(tapRecognizer)
  }
}

extension UIApplication: UIGestureRecognizerDelegate {
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return false
  }
}
