//
//  WatchSessionManager.swift
//  RunCombiWatchExtension
//
//  Created by 임경빈 on 10/5/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation
import WatchConnectivity

import SharedUtility

public final class WatchSessionManager: NSObject, WCSessionDelegate {
  public static let shared = WatchSessionManager()
  
  private override init() {
    super.init()
  }
  
  public func activateSession() {
    if WCSession.isSupported() {
      WCSession.default.delegate = self
      WCSession.default.activate()
    }
  }
  
  // ✅ 워치로 토큰 전송
  public func sendTokenToWatch(_ token: String) -> Bool {
    guard WCSession.default.isPaired else {
      Logger.e("⚠️ Apple Watch가 연결되어 있지 않습니다.")
      return false
    }
    
    guard WCSession.default.isWatchAppInstalled else {
      Logger.e("⚠️ Watch 앱이 설치되어 있지 않습니다.")
      return false
    }
    
    let session = WCSession.default
    let data = ["token": token]

    if session.isReachable {
      WCSession.default.sendMessage(["token": token]) { reply in
        Logger.d("✅ 워치로 토큰 전송 성공: \(reply)")
      } errorHandler: { error in
        Logger.e("❌ 즉시 전송 실패: \(error.localizedDescription), transferUserInfo로 대체")
        session.transferUserInfo(data)
      }
    } else {
        Logger.e("⚠️ 즉시 연결 불가 — transferUserInfo로 전송 예약")
        session.transferUserInfo(data)
    }
    return true
  }
  
  // MARK: - WCSessionDelegate
  public func sessionDidBecomeInactive(_ session: WCSession) {
    Logger.d("📱 sessionDidBecomeInactive 활성화 상태: \(session)")
  }
  
  public func sessionDidDeactivate(_ session: WCSession) {
    Logger.d("📱 sessionDidDeactivate 활성화 상태: \(session)")
  }
  
  public func session(_ session: WCSession,
               activationDidCompleteWith activationState: WCSessionActivationState,
               error: Error?) {
    Logger.d("📱 WCSession 활성화 상태: \(activationState.rawValue)")
    if let error = error {
      Logger.e("⚠️ 활성화 에러: \(error.localizedDescription)")
    }
  }
}
