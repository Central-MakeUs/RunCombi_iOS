//
//  PermissionManager.swift
//  SharedUtility
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import AVFoundation
import UIKit

final public class PermissionManager {
  public static let shared = PermissionManager()
  private init() {}

  /// 카메라 권한 상태 확인
  private func cameraAuthorizationStatus() -> AVAuthorizationStatus {
    return AVCaptureDevice.authorizationStatus(for: .video)
  }

  /// 카메라 권한 요청
  /// - Parameter completion: granted == true 면 허용된 상태입니다.
  public func requestCameraPermission(completion: @escaping (Bool) -> Void) {
    switch cameraAuthorizationStatus() {
    case .authorized:
      completion(true)
    case .notDetermined:
      AVCaptureDevice.requestAccess(for: .video) { granted in
        DispatchQueue.main.async {
          completion(granted)
        }
      }
    case .denied, .restricted:
      completion(false)
    @unknown default:
      completion(false)
    }
  }

  /// (예시) 권한 거부 시 바로 설정 앱 열기
  public func openAppSettings() {
    guard let url = URL(string: UIApplication.openSettingsURLString),
          UIApplication.shared.canOpenURL(url) else { return }
    UIApplication.shared.open(url)
  }
}
