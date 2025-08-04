//
//  PermissionType.swift
//  SharedUtility
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

public enum PermissionType {
  case camera
}

public extension PermissionType {
  var title: String {
    switch self {
    case .camera:
      "카메라 접근 권한 필요"
    }
  }
  
  var description: String {
    switch self {
    case .camera:
      "사진을 찍으려면 카메라 접근 권한이 필요해요.\n설정에서 권한을 허용해주세요."
    }
  }
}
