//
//  ImageLoader.swift
//  SharedUtility
//
//  Created by 임경빈 on 7/27/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public final class ImageLoader {
  public static let shared = ImageLoader()
  private init() {}

  /// URL 문자열을 받아 Data로 내려받는 함수
  public func fetchImageData(from urlString: String) async -> Data? {
    guard let url = URL(string: urlString) else {
      return nil
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      return data
    } catch {
      return nil
    }
  }
}
