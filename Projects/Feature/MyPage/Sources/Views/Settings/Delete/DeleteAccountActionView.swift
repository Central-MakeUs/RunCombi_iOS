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
import ResourceKit
import SharedUtility
import UserInterface

struct DeleteAccountActionView: View {
  @Dependency(\.myPageClient) var myPageClient
  @EnvironmentObject private var userManager: UserManager
  @Environment(\.dismiss) var dismiss
  @State private var selectedSurveys: Set<SurveyType> = []
  @State private var typpedOtherReason = ""
  @State private var isLoading = false
  
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
    
      GeometryReader { proxy in
        ScrollView {
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
                  SurveyRow(
                    type: type,
                    isSelected: selectedSurveys.contains(type)
                  ) {
                    withAnimation {
                      if selectedSurveys.contains(type) {
                        selectedSurveys.remove(type)
                      } else {
                        selectedSurveys.insert(type)
                      }
                    }
                  }
                }
              }
              
              if selectedSurveys.contains(.other) {
                VStack(alignment: .trailing, spacing: 4) {
                  TextEditor(text: $typpedOtherReason)
                    .disableAutocorrection(true)
                    .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                    .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                    .frame(height: 144)
                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
                    .scrollContentBackground(.hidden)
                    .background(Color(R.color.greyscale_02_252525))
                    .cornerRadius(4)
                    .onChange(of: typpedOtherReason) {
                      if typpedOtherReason.count > 100 {
                        typpedOtherReason = String(typpedOtherReason.prefix(100))
                      }
                    }
                    .overlay(alignment: .topLeading) {
                      Text("사유를 입력해주세요")
                        .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                        .foregroundStyle(typpedOtherReason.isEmpty ? Color(R.color.greyscale_04_525252) : .clear)
                        .padding(.leading, 23)
                        .padding(.top, 23)
                    }
                  HStack(spacing: .zero) {
                    Text("\(typpedOtherReason.count)")
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
              deleteMember()
            } label: {
              PrimaryActionLabel(
                text: "회원 탈퇴",
                foregroundColor: selectedSurveys.isEmpty ? Color(R.color.gray_090909): Color(R.color.white_FFFFFF),
                backgroundColor: selectedSurveys.isEmpty ? Color(R.color.gray_353434) : Color(R.color.error_FC5555)
              )
            }
            .disabled(selectedSurveys.isEmpty)
            .padding(.bottom)
          }
          .frame(minHeight: proxy.size.height)
        }
        .scrollIndicators(.hidden)
      }
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
    .overlay {
      if isLoading {
        LoadingOverlay(loadingText: "처리 중")
      }
    }
    .animation(.default, value: isLoading)
    .onAppear {
      UIApplication.shared.hideKeyboard()
    }
  }
  
  private func deleteMember() {
    isLoading = true
    Task {
      defer { isLoading = false }
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await myPageClient.sendLeaveReason(token: token, reason: getReason())
        try await myPageClient.deleteAccount(token: token)
        AppAnalytics.shared.log(.accountDelete(
          reasons: selectedSurveys
            .filter { $0 != .none }
            .map { String(describing: $0) }
            .sorted()
            .joined(separator: ","),
          hasOtherReason: selectedSurveys.contains(.other) && typpedOtherReason.isEmpty == false
        ))
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
  
  private func getReason() -> [String] {
    var reasons = selectedSurveys.map { $0.text }
    if selectedSurveys.contains(.other), !typpedOtherReason.isEmpty {
      reasons.append(typpedOtherReason)
    }
    return reasons
  }
}

#Preview {
  DeleteAccountActionView()
}
