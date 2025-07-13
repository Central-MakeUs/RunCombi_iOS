//
//  Validator.swift
//  SharedUtility
//
//  Created by Groonui on 7/14/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

/// 1) 에러 타입 정의
public enum NameValidationError: LocalizedError {
  /// 한글·영문 외 문자 입력
  case invalidCharacters
  /// 한글만 입력했을 때 6자 초과
  case hangulTooLong
  /// 영문만 또는 혼합 입력 시 10자 초과
  case englishMixedTooLong
  
  // LocalizedError 프로토콜 구현
  public var errorDescription: String? {
    switch self {
    case .invalidCharacters:
      return "한글과 영문만 입력할 수 있어요!"
    case .hangulTooLong:
      return "한글은 최대 5자까지 입력할 수 있어요!"
    case .englishMixedTooLong:
      return "이름은 최대 7자까지 입력할 수 있어요!"
    }
  }
}

/// 2) 실제 유효성 검사 로직 분리
public struct NameValidator {
  public static func validate(_ name: String) throws {
    // 1) 허용할 Hangul 음절 범위 (가–힣)
    let syllables = CharacterSet(charactersIn: "\u{AC00}"..."\u{D7A3}")
    // 2) 호환 자모 범위: ㄱ–ㅎ (U+3131–U+314E) + ㅏ–ㅣ (U+314F–U+3163)
    let consonants = CharacterSet(charactersIn: "\u{3131}"..."\u{314E}")
    let vowels     = CharacterSet(charactersIn: "\u{314F}"..."\u{3163}")
    // 3) 합쳐서 “한글” 집합
    let hangulSet = syllables
      .union(consonants)
      .union(vowels)
    // 4) 영문 집합
    let englishSet = CharacterSet(charactersIn: "A"..."Z")
      .union(CharacterSet(charactersIn: "a"..."z"))
    // 5) 최종 허용 문자 집합
    let allowedSet = hangulSet.union(englishSet)

    // 금지 문자 검사
    if name.rangeOfCharacter(from: allowedSet.inverted) != nil {
      throw NameValidationError.invalidCharacters
    }

    // 한글만 있는지 확인
    let isHangulOnly = name.unicodeScalars.allSatisfy { hangulSet.contains($0) }
    let count = name.count

    // 길이 제한 검사
    if isHangulOnly {
      if count > 5 {
        throw NameValidationError.hangulTooLong
      }
    } else {
      if count > 7 {
        throw NameValidationError.englishMixedTooLong
      }
    }
  }
}
