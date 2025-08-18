//
//  DiagonalCutShape.swift
//  UserInterface
//
//  Created by 임경빈 on 8/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

/// 특정 모서리(Top-Right, Bottom-Left)만 사선으로 잘라내는 Shape
public struct DiagonalCutShape: Shape {
  /// cutSize.width  = 가로로 잘려나갈 길이
  /// cutSize.height = 세로로 잘려나갈 길이
  var cutSize: CGSize
  
  public init(cutSize: CGSize) {
    self.cutSize = cutSize
  }
  
  public func path(in rect: CGRect) -> Path {
    let dx = cutSize.width
    let dy = cutSize.height
    
    var path = Path()
    // 시작 (좌측 상단)
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    // Top edge → Top-Right 컷 시작
    path.addLine(to: CGPoint(x: rect.maxX - dx, y: rect.minY))
    // Right edge → Top-Right 컷 끝
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + dy))
    // 우측 아래 모서리
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
    // Bottom edge → Bottom-Left 컷 시작
    path.addLine(to: CGPoint(x: rect.minX + dx, y: rect.maxY))
    // Left edge → Bottom-Left 컷 끝
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - dy))
    // 닫기
    path.closeSubpath()
    return path
  }
}
