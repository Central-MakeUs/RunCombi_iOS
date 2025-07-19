//
//  EditCombiProfileView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import SharedUtility
import UserInterface

struct EditCombiProfileView: View {
  @State private var selectedUserImageData: Data?
  @State private var typpedCombiName: String = ""
  @State private var errorMessage: String?
  @State private var lastValidNickname: String = ""
  @State private var typpedAge: String = ""
  @State private var typpedWeight: String = ""
  @State private var selectedWalkStyle: WalkStyleType = .none
  
  var body: some View {
    VStack {
      EditHeader(title: "콤비 정보 수정") {
        // TODO: - 콤비 정보 수정
      }
      
      ScrollView {
        VStack(spacing: 32) {
        SelectImageView(type: .user, selectedImageData: $selectedUserImageData)
        
          VStack(spacing: 24) {
            EditTextField(type: .combiName, typpedText: $typpedCombiName, errorMessage: $errorMessage)
              .onChange(of: typpedCombiName) { oldValue, newValue in
                handleNicknameChange(oldValue: oldValue, newValue: newValue)
              }
            
            EditTextField(type: .combiAge, typpedText: $typpedAge, errorMessage: .constant(nil))
            
            EditTextField(type: .combiWeight, typpedText: $typpedWeight, errorMessage: .constant(nil))
            
            VStack(alignment: .leading, spacing: 6) {
              Text("산책스타일")
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              
              VStack(spacing: 14) {
                ForEach(WalkStyleType.allCases, id: \.self) { type in
                  if type != .none {
                    Button {
                      selectedWalkStyle = type
                    } label: {
                      Text(type.rawValue)
                        .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                        .foregroundStyle(selectedWalkStyle == type ? Color(R.color.greyscale_03_333333): Color(R.color.greyscale_08_EDEDED))
                        .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(selectedWalkStyle == type ? Color(R.color.primary_01_D7FE63): Color(R.color.greyscale_04_525252))
                        .clipShape(.rect(cornerRadius: 6))
                    }
                  }
                }
              }
            }
          }
        }
        .padding(.top, 32)
      }
      .scrollIndicators(.never)
    }
    .padding(.horizontal, 20)
    .padding(.bottom, 20)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .onAppear {
      UIApplication.shared.hideKeyboard()
    }
  }
  
  private func handleNicknameChange(oldValue: String, newValue: String) {
    // 1) 되돌린 값이면 아무것도 안 함
    guard newValue != lastValidNickname else { return }
    
    // 2) 유효성 검사
    do {
      try NameValidator.validate(newValue)
      // 통과 시
      lastValidNickname = newValue
      errorMessage = nil
    } catch let error as NameValidationError {
      // 실패 시
      errorMessage = error.errorDescription
      // 뷰모델 값 되돌리기
      typpedCombiName = lastValidNickname
    } catch {
      errorMessage = error.localizedDescription
    }
  }
}
