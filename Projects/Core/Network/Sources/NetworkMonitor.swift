//
//  NetworkMonitor.swift
//  CoreNetwork
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Network

public class NetworkMonitor {
  public static let shared = NetworkMonitor()
  private let monitor = NWPathMonitor()
  private let queue = DispatchQueue.global(qos: .background)
  public private(set)var isConnected: Bool = true
  
  private init() {
    monitor.pathUpdateHandler = { path in
      self.isConnected = path.status == .satisfied
    }
    monitor.start(queue: queue)
  }
}
