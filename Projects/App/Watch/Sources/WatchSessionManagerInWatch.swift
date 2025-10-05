//
//  WatchSessionManagerInWatch.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 10/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation
import WatchConnectivity
import Combine

import SharedUtility

final class WatchSessionManagerInWatch: NSObject, ObservableObject, WCSessionDelegate {
  static let shared = WatchSessionManagerInWatch()
  
  @Published var token: String?  // ✅ 아이폰에서 받은 토큰 저장
  
  private override init() {
    super.init()
  }
  
  func activateSession() {
    if WCSession.isSupported() {
      WCSession.default.delegate = self
      WCSession.default.activate()
      Logger.d("⌚️ WCSession 활성화 완료")
    }
  }
  
  // ✅ iPhone에서 sendMessage()로 보낸 메시지 받기
  func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    if let token = message["token"] as? String {
      Logger.d("📩 iPhone으로부터 토큰 수신: \(token)")
      self.token = token
//      TokenManager.shared.accessToken = token
    }
  }
  
  // ✅ iPhone에서 transferUserInfo()로 보낸 데이터 받기
  func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
    if let token = userInfo["token"] as? String {
      Logger.d("📥 transferUserInfo로 토큰 수신: \(token)")
      self.token = token
//      TokenManager.shared.accessToken = token
    }
  }
  
  // MARK: - Delegate 필수 구현
  func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    Logger.d("⌚️ WCSession 상태: \(activationState.rawValue)")
    if let error = error {
      Logger.e("⚠️ 세션 에러: \(error.localizedDescription)")
    }
  }
}
