//
//  EditCombiProfileView.swift
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

struct EditCombiProfileView: View {
  @Dependency(\.myPageClient) var myPageClient
  @EnvironmentObject var userManager: UserManager
  @Environment(\.dismiss) var dismiss
  
  @State private var isChangedImage = false
  @State private var selectedCombiImageData: Data?
  @State private var typpedCombiName: String = ""
  @State private var errorMessage: String?
  @State private var lastValidNickname: String = ""
  @State private var typpedAge: String = ""
  @State private var typpedWeight: String = ""
  @State private var selectedWalkStyle: WalkStyleType = .none
  
  var isDisabled: Bool {
    let combi = userManager.petList.first(where: { $0.petId == combiID })
    return typpedCombiName == (combi?.name).ifNil(then: "") &&
    typpedAge == "\((combi?.age).ifNil(then: 0))" &&
    typpedWeight == "\((combi?.weight).ifNil(then: 0))" &&
    selectedWalkStyle == (combi?.runStyle).ifNil(then: .none) &&
    isChangedImage == false
  }
  
  @State private var isDeleteCombiSheet: Bool = false
  
  @Binding var combiID: Int
  
  var body: some View {
    VStack {
      EditHeader(title: "콤비 정보 수정", isDisabled: isDisabled) {
        updatePetProfile()
      }
      
      ScrollView {
        VStack(spacing: 32) {
        SelectImageView(type: .dog, selectedImageData: $selectedCombiImageData) {
          isChangedImage = true
        }
        
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
          
          if userManager.petList.count > 1 {
            Button {
              isDeleteCombiSheet = true
            } label: {
              Text("반려견 삭제")
                .underline()
                .foregroundStyle(Color(R.color.greyscale_06_999999))
                .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
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
    .bottomSheet(isPresented: $isDeleteCombiSheet) {
      VStack(spacing: 32) {
        VStack(spacing: 10) {
          Text("정말 \(typpedCombiName)를 삭제하시겠어요?")
            .pretendardFont(size: 20, weight: .semiBold, lineHeight: 32)
            .foregroundStyle(Color(R.color.white_FFFFFF))
            .frame(maxWidth: .infinity, alignment: .leading)
          
          Text("콤비의 기록과 추억도 함께 사라져요,,,\n기록은 복구할 수 없으니 신중히 결정해주세요.")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_07_B3B3B3))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        HStack(spacing: 10) {
          Button {
            deleteCombi()
          } label: {
            PrimaryActionLabel(
              text: "삭제",
              foregroundColor: Color(R.color.white_FFFFFF),
              backgroundColor: Color(R.color.error_FC5555)
            )
          }
          
          Button {
            isDeleteCombiSheet = false
          } label: {
            PrimaryActionLabel(
              text: "아니요",
              foregroundColor: Color(R.color.greyscale_08_EDEDED),
              backgroundColor: Color(R.color.greyscale_04_525252)
            )
          }
        }
      }
      .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
    }
    .onAppear {
      UIApplication.shared.hideKeyboard()
      let combi = userManager.petList.first(where: { $0.petId == combiID })
      typpedCombiName = (combi?.name).ifNil(then: "")
      typpedAge = "\((combi?.age).ifNil(then: 0))"
      typpedWeight = "\((combi?.weight).ifNil(then: 0))"
      selectedWalkStyle = (combi?.runStyle).ifNil(then: .none)
      Task { selectedCombiImageData = await ImageLoader.shared.fetchImageData(from: (combi?.petImageUrl).ifNil(then: ""))}
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
  
  private func updatePetProfile() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        let updatePetDetail = UpdatePetDetailModel(
          petId: (userManager.petList.first(where: { $0.petId == combiID })?.petId).ifNil(then: 0),
          name: typpedCombiName,
          age: Int(typpedAge).ifNil(then: 0),
          weight: Double(typpedWeight).ifNil(then: 0),
          runStyle: selectedWalkStyle
        )
        
        try await myPageClient.updatePetDetail(
          token: token,
          updatePetDetail: updatePetDetail,
          petImageData: selectedCombiImageData
        )
        userManager.shouldRefresh = true
        dismiss()
      } catch {
        Logger.e("\(error)")
      }
    }
  }
  
  private func deleteCombi() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await myPageClient.deletePet(token: token, petID: combiID)
        userManager.shouldRefresh = true
        dismiss()
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
