//
//  UINavigationController+Extension.swift
//  UserInterface
//
//  Created by Groonui on 7/13/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

/// 커스텀 백버튼 사용을 위해 .navigationBarBackButtonHidden()을 적용하면
/// 시스템 백스와이프(interactivePopGestureRecognizer)가 비활성화되므로 다시 활성화한다.
extension UINavigationController: UIGestureRecognizerDelegate {
  /// 백스와이프를 막아야 하는 화면(운동 중, 가입 완료)에서 false로 설정
  /// 주의: 차단 화면 위에 차단 화면을 푸시하면 onAppear/onDisappear 순서 문제로 풀릴 수 있음
  /// → 그런 플로우는 차단 대신 내비게이션 스택 재구성으로 해결할 것 (운동 종료 플로우 참고)
  public static var isBackSwipeEnabled = true

  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }

  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    Self.isBackSwipeEnabled && viewControllers.count > 1
  }
}

public extension View {
  /// 현재 화면이 보이는 동안 백스와이프 제스처를 비활성화한다.
  func backSwipeDisabled() -> some View {
    self
      .onAppear { UINavigationController.isBackSwipeEnabled = false }
      .onDisappear { UINavigationController.isBackSwipeEnabled = true }
  }
}
