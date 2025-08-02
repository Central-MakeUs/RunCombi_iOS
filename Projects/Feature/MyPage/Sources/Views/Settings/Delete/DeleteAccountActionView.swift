//
//  DeleteAccountActionView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainMyPage
import KakaoSDKUser
import ResourceKit
import SharedUtility
import UserInterface

struct DeleteAccountActionView: View {
  @Dependency(\.myPageClient) var myPageClient
  @EnvironmentObject private var userManager: UserManager
  @Environment(\.dismiss) var dismiss
  @State private var selectedSurvey: SurveyType = .none
  @State private var otherReason = ""
  
  var body: some View {
    VStack(spacing: 16) {
      HStack {
        Button {
          dismiss()
        } label: {
          Image(R.image.backButton)
        }
        Spacer()
      }
      .padding(.top, 16)
      
      VStack {
        VStack(spacing: 4) {
          Text("떠나시는 이유를\n알려주세요")
            .pretendardFont(size: 24, weight: .semiBold, lineHeight: 36)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .frame(maxWidth: .infinity, alignment: .leading)
          Text("다시 사용하고 싶도록 개선해볼게요!")
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED).opacity(0.72))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        
        VStack(spacing: 24) {
          ForEach(SurveyType.allCases, id: \.self) { type in
            if type != .none {
              SurveyRow(type: type, isSelected: selectedSurvey == type
              ) {
                withAnimation {
                  selectedSurvey = type
                }
              }
            }
          }
          
          if selectedSurvey == .other {
            VStack(alignment: .trailing, spacing: 4) {
              TextEditor(text: $otherReason)
                .disableAutocorrection(true)
                .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                .frame(height: 144)
                .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                .scrollContentBackground(.hidden)
                .background(Color(R.color.greyscale_02_252525))
                .cornerRadius(4)
                .onChange(of: otherReason) {
                  if otherReason.count > 100 {
                    otherReason = String(otherReason.prefix(100))
                  }
                }
                .overlay(alignment: .topLeading) {
                  Text("사유를 입력해주세요")
                    .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                    .foregroundStyle(otherReason.isEmpty ? Color(R.color.greyscale_04_525252) : .clear)
                    .padding(.leading, 23)
                    .padding(.top, 23)
                }
              HStack(spacing: .zero) {
                Text("\(otherReason.count)")
                  .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                Text("/100")
                  .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
                  .foregroundStyle(Color(R.color.white_FFFFFF).opacity(0.32))
              }
            }
          }
        }
        .padding(.top, 40)
        
        Spacer()
        
        Button {
          // TODO: - 회원 탈퇴 로직 추가
          deleteMember()
        } label: {
          PrimaryActionLabel(
            text: "회원 탈퇴",
            foregroundColor: selectedSurvey == .none ? Color(R.color.gray_090909): Color(R.color.white_FFFFFF),
            backgroundColor: selectedSurvey == .none ? Color(R.color.gray_353434) : Color(R.color.error_FC5555)
          )
        }
        .disabled(selectedSurvey == .none)
      }
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
    .onAppear {
      UIApplication.shared.hideKeyboard()
    }
  }
  
  private func deleteMember() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await myPageClient.deleteAccount(token: token)
        TokenManager.shared.clearTokens()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
          withAnimation {
            userManager.isDeleteAccountSnackBarPresented = true
          }
        }
        userManager.clearUserManager()
      } catch {
        Logger.e("탈퇴 실패: \(error)")
      }
    }
  }
}

#Preview {
  DeleteAccountActionView()
}
