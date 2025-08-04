//
//  InquiryView.swift
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

public struct InquiryView: View {
  @Dependency(\.myPageClient) var myPageClient
  @Environment(\.dismiss) var dismiss
  @State private var typpedOpinionText = ""
  @FocusState private var isFocused: Bool
  
  @Binding private var path: NavigationPath
  @Binding private var snackBarItem: String
  
  public init(path: Binding<NavigationPath>, snackBarItem: Binding<String>) {
    self._path = path
    self._snackBarItem = snackBarItem
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack(spacing: 36) {
        VStack(spacing: .zero) {
          Text("런콤비 개선 제안")
            .pretendardFont(size: 24, weight: .semiBold, lineHeight: 36)
            .foregroundStyle(Color(R.color.white_FFFFFF))
            .frame(maxWidth: .infinity, alignment: .leading)
          Text("작은 의견도 런콤비에겐 큰 힘이 돼요!")
            .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_05_757575))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.top, 32)
        
        VStack(alignment: .trailing, spacing: 4) {
          TextEditor(text: $typpedOpinionText)
            .focused($isFocused)
            .disableAutocorrection(true)
            .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
            .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            .frame(maxHeight: 200)
            .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
            .scrollContentBackground(.hidden)
            .background(Color(R.color.greyscale_02_252525))
            .cornerRadius(4)
            .onChange(of: typpedOpinionText) {
              if typpedOpinionText.count > 100 {
                typpedOpinionText = String(typpedOpinionText.prefix(100))
              }
            }
            .overlay(alignment: .topLeading) {
              Text("의견을 작성해주세요")
                .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                .foregroundStyle(typpedOpinionText.isEmpty ? Color(R.color.greyscale_04_525252) : .clear)
                .padding(.leading, 23)
                .padding(.top, 23)
            }
          HStack(spacing: .zero) {
            Text("\(typpedOpinionText.count)")
              .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
              .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
            Text("/100")
              .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
              .foregroundStyle(Color(R.color.white_FFFFFF).opacity(0.32))
          }
        }
        
        Spacer()
        
        HStack(spacing: 10) {
          Button {
            dismiss()
          } label: {
            PrimaryActionLabel(text: "이전", foregroundColor: Color(R.color.greyscale_08_EDEDED), backgroundColor: Color(R.color.greyscale_04_525252))
          }
          
          Button {
            sendSuggestion()
          } label: {
            PrimaryActionLabel(
              text: "완료",
              foregroundColor: typpedOpinionText.isEmpty ? Color(R.color.gray_090909): Color(R.color.greyscale_02_252525),
              backgroundColor: typpedOpinionText.isEmpty ? Color(R.color.gray_353434) : Color(R.color.primary_01_D7FE63)
            )
          }
          .disabled(typpedOpinionText.isEmpty)
        }
      }
      .padding(.horizontal, 20)
      .padding(.bottom, 16)
    }
    .navigationBarBackButtonHidden()
    .onAppear {
      isFocused = true
    }
  }
  
  private func sendSuggestion() {
    Task {
      do {
        let token = TokenManager.shared.accessToken.ifNil(then: "")
        try await myPageClient.suggestion(token: token, message: typpedOpinionText)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
          withAnimation {
            snackBarItem = "런콤비 개선 제안 완료!"
          }
        }
        path.removeLast(path.count)
      } catch {
        Logger.e("\(error)")
      }
    }
  }
}
