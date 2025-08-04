//
//  PermissionManager.swift
//  SharedUtility
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import AVFoundation
import CoreLocation
import UIKit

public enum LocationPermissionStatus {
  case authorized, denied, notDetermined, restricted
}

final public class PermissionManager: NSObject {
  public static let shared = PermissionManager()
  private let locationManager = CLLocationManager()
  private var locationCompletion: ((Bool) -> Void)?

  private override init() {
    super.init()
    locationManager.delegate = self
  }

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
  
  // MARK: – Location
  /// 인스턴스 프로퍼티로 권한 상태 조회
  public func locationPermissionStatus() -> LocationPermissionStatus {
    switch locationManager.authorizationStatus {
    case .authorizedAlways, .authorizedWhenInUse:
      return .authorized
    case .denied:
      return .denied
    case .restricted:
      return .restricted
    case .notDetermined:
      return .notDetermined
    @unknown default:
      return .denied
    }
  }

  /// 권한 요청
  public func requestLocationPermission(completion: @escaping (Bool) -> Void) {
    let status = locationPermissionStatus()
    switch status {
    case .authorized:
      completion(true)
    case .notDetermined:
      locationCompletion = completion
      locationManager.requestWhenInUseAuthorization()
    case .denied, .restricted:
      completion(false)
    }
  }
}

extension PermissionManager: CLLocationManagerDelegate {
  /// iOS 14+ 에서 호출되는 delegate
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    guard let callback = locationCompletion else { return }
    let status = manager.authorizationStatus
    callback(status == .authorizedAlways || status == .authorizedWhenInUse)
    locationCompletion = nil
  }

  /// iOS 13 이하 호환용 (deprecated 됐지만 안전하게 남겨둡니다)
  public func locationManager(_ manager: CLLocationManager,
                              didChangeAuthorization status: CLAuthorizationStatus) {
    locationManagerDidChangeAuthorization(manager)
  }
}
