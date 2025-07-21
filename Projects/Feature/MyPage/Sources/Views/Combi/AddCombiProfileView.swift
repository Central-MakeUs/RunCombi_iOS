//
//  AddCombiProfileView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import LocalizableStringManager
import ResourceKit
import SharedUtility
import UserInterface

private enum DogInfoInputType: Double {
  case name = 0.33
  case body = 0.66
  case walkStyle = 1
}

struct AddCombiProfileView: View {
  @Environment(\.dismiss) var dismiss
  @State private var dogInfoInputType: DogInfoInputType = .name
  @State private var selectedDogImageData: Data?
  
  @State private var typpedDogName: String = ""
  @State private var lastValidDogName: String = ""
  @State private var errorMessage: String?
  
  @State private var typpedDogAge: String = ""
  @State private var typpedDogWeight: String = ""
  var isButtonDisabled: Bool {
    typpedDogAge.isEmpty ||
    typpedDogWeight.isEmpty ||
    Int(typpedDogAge).ifNil(then: 0) < 1 ||
    Int(typpedDogAge).ifNil(then: 0) > 25 ||
    Double(typpedDogWeight).ifNil(then: 0) < 0.5 ||
    Double(typpedDogWeight).ifNil(then: 0) > 100
  }
  
  @State private var selectedWalkStyle: WalkStyleType = .none
  
  var body: some View {
    VStack(spacing: 0) {
      VStack(spacing: 11) {
        ZStack {
          HStack {
            Button {
              navgateBack()
            } label: {
              Image(R.image.backButton)
            }
            Spacer()
          }
          
          HStack {
            Spacer()
            Text("반려견 정보")
              .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            Spacer()
          }
        }
        
        ProgressBar.create(
          value: dogInfoInputType.rawValue,
          height: 4,
          foregroundColor: Color(R.color.primary_01_D7FE63),
          backgroundColor: Color(R.color.gray_121F23),
          radius: 3
        )
      }
      .padding(.vertical, 34)
      
      switch dogInfoInputType {
      case .name:
        VStack(spacing: 35) {
          SelectImageView(type: .dog, selectedImageData: $selectedDogImageData)
          
          VStack(spacing: 5) {
            HStack {
              Text("이름")
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              Spacer()
              Text(errorMessage.ifNil(then: "한글 5자/ 영문 7자 이하"))
                .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
                .foregroundStyle(errorMessage == nil ? Color(R.color.greyscale_06_999999) : Color(R.color.error_FC5555))
            }
            
            TextField(
              "",
              text: $typpedDogName,
              prompt: Text("콤비")
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            )
            .frame(height: 40)
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(errorMessage == nil ? Color(R.color.greyscale_08_EDEDED) : Color(R.color.error_FC5555))
            .padding(.horizontal, 12)
            .background(Color(R.color.greyscale_04_525252))
            .clipShape(.rect(cornerRadius: 6))
            .overlay(
              RoundedRectangle(cornerRadius: 6)
                .stroke(
                  errorMessage == nil ? Color.clear : Color(R.color.error_FC5555),
                  lineWidth: 1
                )
            )
            .onChange(of: typpedDogName) { oldValue, newValue in
              handleDogNameChange(oldValue: oldValue, newValue: newValue)
            }
          }
          
          Spacer()
          
          VStack(spacing: 32) {
            Text("다른 반려견도 나중에 추가할 수 있어요")
              .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
            
            Button {
              dogInfoInputType = .body
            } label: {
              PrimaryActionLabel(
                text: String(key: "Common.Next"),
                backgroundColor: typpedDogName.isEmpty || errorMessage != nil ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
              )
            }
            .disabled(typpedDogName.isEmpty || errorMessage != nil)
          }
        }
      case .body:
        VStack(spacing: 78) {
          VStack(spacing: 9) {
            Text("반려견 정보를 알려주세요")
              .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
              .foregroundStyle(Color(R.color.white_FFFFFF))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("외부에 공개되지 않아요")
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          VStack(spacing: 27) {
            HStack {
              Text("나이")
                .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              
              Spacer()
              
              HStack {
                TextField(
                  "",
                  text: $typpedDogAge,
                  prompt: Text("5")
                    .foregroundStyle(Color(R.color.greyscale_06_999999))
                )
                .keyboardType(.numberPad)
                .frame(height: 40)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .onChange(of: typpedDogAge) { oldValue, newValue in
                  typpedDogAge = validatedNumericInput(
                    newValue: newValue,
                    oldValue: oldValue
                  )
                }
                
                Spacer(minLength: 4)
                
                Text("살")
                  .foregroundStyle(Color(R.color.greyscale_06_999999))
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              }
              .frame(maxWidth: 134)
              .padding(.horizontal, 12)
              .background(Color(R.color.greyscale_04_525252))
              .clipShape(.rect(cornerRadius: 6))
            }
            
            HStack {
              Text("몸무게")
                .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              
              Spacer()
              
              HStack {
                TextField(
                  "",
                  text: $typpedDogWeight,
                  prompt: Text("5.5")
                    .foregroundStyle(Color(R.color.greyscale_06_999999))
                )
                .keyboardType(.decimalPad)
                .frame(height: 40)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .onChange(of: typpedDogWeight) { oldValue, newValue in
                  typpedDogWeight = validatedDogWeightInput(
                    newValue: newValue,
                    oldValue: oldValue
                  )
                }
                
                Spacer(minLength: 4)
                
                Text("kg")
                  .foregroundStyle(Color(R.color.greyscale_06_999999))
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              }
              .frame(maxWidth: 134)
              .padding(.horizontal, 12)
              .background(Color(R.color.greyscale_04_525252))
              .clipShape(.rect(cornerRadius: 6))
            }
          }
        }
        
        Spacer()
        
        Button {
          dogInfoInputType = .walkStyle
        } label: {
          PrimaryActionLabel(
            text: String(key: "Common.Next"),
            backgroundColor: isButtonDisabled ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
          )
        }
        .disabled(isButtonDisabled)
      case .walkStyle:
        VStack(spacing: 49) {
          VStack(spacing: 9) {
            Text("산책스타일을 알려주세요")
              .pretendardFont(size: 22, weight: .semiBold, lineHeight: 34)
              .foregroundStyle(Color(R.color.white_FFFFFF))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("더 정확한 반려견 소모 칼로리 계산을 위해 필요해요")
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_06_999999))
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          VStack(spacing: 5) {
            Text("산책스타일")
              .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
              .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 14) {
              ForEach(WalkStyleType.allCases, id: \.self) { type in
                if type != .none {
                  Button {
                    selectedWalkStyle = type
                  } label: {
                    Text(type.rawValue)
                      .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                      .foregroundStyle(selectedWalkStyle == type ? Color(R.color.greyscale_03_333333):  Color(R.color.greyscale_08_EDEDED))
                      .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .background(selectedWalkStyle == type ? Color(R.color.primary_01_D7FE63):  Color(R.color.greyscale_04_525252))
                      .clipShape(.rect(cornerRadius: 6))
                  }
                }
              }
            }
          }
          
          Spacer()
          
          Button {
            // TODO: 반려견 정보 추가
            dismiss()
          } label: {
            PrimaryActionLabel(
              text: "완료",
              backgroundColor: selectedWalkStyle == .none ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
            )
          }
          .disabled(selectedWalkStyle == .none)
        }
      }
    }
    .ignoresSafeArea(.keyboard)
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .navigationBarBackButtonHidden(true)
    .onAppear {
      UIApplication.shared.hideKeyboard()
    }
  }
}

private extension AddCombiProfileView {
  func navgateBack() {
    switch dogInfoInputType {
    case .name:
      dismiss()
    case .body:
      dogInfoInputType = .name
    case .walkStyle:
      dogInfoInputType = .body
    }
  }
  
  func handleDogNameChange(oldValue: String, newValue: String) {
    // 1) 되돌린 값이면 아무것도 안 함
    guard newValue != lastValidDogName else { return }
    
    // 2) 유효성 검사
    do {
      try NameValidator.validate(newValue)
      // 통과 시
      lastValidDogName = newValue
      errorMessage = nil
    } catch let error as NameValidationError {
      // 실패 시
      errorMessage = error.errorDescription
      // 뷰모델 값 되돌리기
      typpedDogName = lastValidDogName
    } catch {
      errorMessage = error.localizedDescription
    }
  }
  
  func validatedNumericInput(newValue: String, oldValue: String) -> String {
    // 빈 문자열은 그대로 통과
    guard !newValue.isEmpty else { return newValue }
    // 숫자만 필터링
    let filtered = newValue.filter(\.isNumber)
    // 원본과 같고 Int 변환 가능하면 newValue, 아니면 oldValue
    return (filtered == newValue && Int(filtered) != nil) ? newValue : oldValue
  }
  
  func validatedDogWeightInput(newValue: String, oldValue: String) -> String {
    // 1) 빈 문자열 입력은 그대로 허용 (사용자가 지우는 중일 때)
    guard !newValue.isEmpty else { return newValue }
    
    // 2) 숫자와 점(.) 이외의 문자가 섞여 있으면 이전 값으로
    let invalidChars = CharacterSet(charactersIn: "0123456789.").inverted
    guard newValue.rangeOfCharacter(from: invalidChars) == nil else {
      return oldValue
    }
    
    // 3) 점이 1개 초과 사용된 경우(“1.2.3”)는 이전 값으로
    let dotCount = newValue.filter { $0 == "." }.count
    guard dotCount <= 1 else {
      return oldValue
    }
    
    // 4) 소수점 뒤 자릿수가 1자리 초과면 이전 값으로
    if let dotIndex = newValue.firstIndex(of: ".") {
      let decimals = newValue[newValue.index(after: dotIndex)...]
      guard decimals.count <= 1 else {
        return oldValue
      }
    }
    
    // 5) Double 변환 후 범위 검사
    if let value = Double(newValue), value >= 0.5, value <= 100 {
      return newValue
    } else {
      return oldValue
    }
  }
}
