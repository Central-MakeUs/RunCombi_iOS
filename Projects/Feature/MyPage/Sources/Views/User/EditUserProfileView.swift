//
//  EditUserProfileView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainMyPage
import ResourceKit
import SharedUtility
import UserInterface

struct EditUserProfileView: View {
  @Dependency(\.myPageClient) var myPageClient
  @EnvironmentObject var userManager: UserManager
  @Environment(\.dismiss) var dismiss
  
  @State private var selectedUserImageData: Data?
  @State private var typpedNickName: String = ""
  @State private var errorMessage: String?
  @State private var lastValidNickname: String = ""
  @State private var selectedGender: GenderType = .none
  @State private var typpedHeight: String = ""
  @State private var typpedWeight: String = ""
  
  var body: some View {
    VStack(spacing: 0) {
      EditHeader(title: "내 정보 수정") {
        updateUserProfile()
      }
      
      ScrollView {
        VStack(spacing: 32) {
        SelectImageView(type: .user, selectedImageData: $selectedUserImageData)
        
          VStack(spacing: 24) {
            EditTextField(type: .userName, typpedText: $typpedNickName, errorMessage: $errorMessage)
              .onChange(of: typpedNickName) { oldValue, newValue in
                handleNicknameChange(oldValue: oldValue, newValue: newValue)
              }
            
            VStack(alignment: .leading, spacing: 6) {
              Text("성별")
                .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              
              HStack(spacing: 12) {
                Button {
                  selectedGender = .male
                } label: {
                  Text("남성")
                    .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                    .foregroundStyle(selectedGender == .male ? Color(R.color.black_000000) : Color(R.color.greyscale_06_999999))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 48)
                    .padding(.leading, 16)
                    .background(selectedGender == .male ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_04_525252))
                    .clipShape(.rect(cornerRadius: 6))
                }
                
                Button {
                  selectedGender = .female
                } label: {
                  Text("여성")
                    .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                    .foregroundStyle(selectedGender == .female ? Color(R.color.black_000000) : Color(R.color.greyscale_06_999999))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(height: 48)
                    .padding(.leading, 16)
                    .background(selectedGender == .female ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_04_525252))
                    .clipShape(.rect(cornerRadius: 6))
                }
              }
            }
            
            EditTextField(type: .userHeight, typpedText: $typpedHeight, errorMessage: .constant(nil))
            
            EditTextField(type: .userWeight, typpedText: $typpedWeight, errorMessage: .constant(nil))
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
      typpedNickName = userManager.member.nickname
      typpedHeight = "\(userManager.member.height)"
      typpedWeight = "\(userManager.member.weight)"
      selectedGender = userManager.member.gender
      Task { selectedUserImageData = await ImageLoader.shared.fetchImageData(from: userManager.member.profileImgUrl) }
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
      typpedNickName = lastValidNickname
    } catch {
      errorMessage = error.localizedDescription
    }
  }
  
  private func updateUserProfile() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        let updateMemberDetail = UpdateMemberDetailModel(
          nickname: typpedNickName,
          gender: selectedGender.rawValue,
          height: Int(typpedHeight).ifNil(then: 0),
          weight: Int(typpedWeight).ifNil(then: 0)
        )
        
        try await myPageClient.updateMemberDetail(
          token: token,
          updateMemberDetail: updateMemberDetail,
          memberImageData: selectedUserImageData
        )
        userManager.shouldRefresh = true
        dismiss()
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
