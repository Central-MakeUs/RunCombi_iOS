//
//  UIImage+Extension.swift
//  SharedUtility
//
//  Created by 임경빈 on 9/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import UIKit

public extension UIImage {
  func normalizedUp() -> UIImage {
    if imageOrientation == .up { return self }
    UIGraphicsBeginImageContextWithOptions(size, false, scale)
    draw(in: CGRect(origin: .zero, size: size))
    let normalized = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return normalized ?? self
  }
}
