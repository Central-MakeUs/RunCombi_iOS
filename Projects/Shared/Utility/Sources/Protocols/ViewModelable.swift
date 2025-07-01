//
//  ViewModelable.swift
//  SharedUtility
//
//  Created by Junghyun Lee on 4/24/25.
//
//  Copyright © 2025 com.deepfine. All rights reserved.

import SwiftUI

public protocol ViewModelable: ObservableObject {
  associatedtype Action
  associatedtype State
  
  var state: State { get set }
  func send(action: Action)
}
