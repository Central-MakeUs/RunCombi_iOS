//
//  ResultModel.swift
//  CoreNetwork
//
//  Created by 임경빈 on 7/12/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public struct ResultModel<T: Decodable>: Decodable {
  public let isSuccess: Bool
  public let code: String
  public let message: String
  public let result: T?
}
