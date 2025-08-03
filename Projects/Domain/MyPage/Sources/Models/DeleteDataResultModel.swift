//
//  DeleteDataResultModel.swift
//  DomainExercise
//
//  Created by 임경빈 on 8/3/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

struct DeleteDataResultModel: Decodable {
  let resultPetName: [String]?
  let resultRun: Int?
  let resultRunImage: Int?
  
  func toEntity() -> DeleteDataResult {
    return DeleteDataResult(
      resultPetName: resultPetName.ifNil(then: []),
      resultRun: resultRun.ifNil(then: 0),
      resultRunImage: resultRunImage.ifNil(then: 0)
    )
  }
}
