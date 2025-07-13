//
//  ServiceAgreementView.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import LocalizableStringManager
import UserInterface

public struct ServiceAgreementView: View {
  
  @ObservedObject private var viewModel = SignUpViewModel()
  @State private var isUserInfoInputViewPresented = false
  
  public init() {}
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 57) {
      Text(String(key: "SignUp.Agreement.Title"))
        .customFont(.heading1)
        .foregroundStyle(Color(R.color.white_FFFFFF))
        .padding(.horizontal, 20)
      
      VStack {
        Button {
          withAnimation {
            viewModel.send(action: .didTapAllAgreement)
          }
        } label: {
          HStack {
            Text(String(key: "SignUp.Agreement.SelectAll"))
              .pretendardFont(size: 16, weight: .medium, lineHeight: 20)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            Spacer()
            if viewModel.isAllAgreed {
              Image(R.image.checkBox)
            } else {
              Rectangle()
                .fill(Color(R.color.gray_292929))
                .frame(width: 20, height: 20)
                .clipShape(.rect(cornerRadius: 2))
            }
          }
        }
        .padding(.horizontal, 20)
        
        Rectangle()
          .fill(Color(R.color.gray_353434))
          .frame(maxWidth: .infinity)
          .frame(height: 0.8)
          .padding(.top, 27)
        
        VStack(spacing: 27) {
          ForEach(AgreementType.allCases, id: \.self) { type in
            ServiceAgreementRow(type: type, isSelected: viewModel.state.agreementSelections.contains(type)
            ) {
              withAnimation {
                viewModel.send(action: .didTapAgreement(type))
              }
            }
          }
        }
        .padding(.top, 32)
        .padding(.horizontal, 20)
      }
      
      Spacer()
      
      Button {
        viewModel.send(action: .didTapNextInAgreement)
        isUserInfoInputViewPresented = true
      } label: {
        PrimaryActionLabel(
          text: String(key: "Common.Next"),
          backgroundColor: viewModel.isAllAgreed ? Color(R.color.primary_01_D7FE63) : Color(R.color.gray_353434)
        )
      }
      .disabled(viewModel.isAllAgreed == false)
      .padding(.horizontal, 20)
    }
    .padding(.top, 84)
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .navigationBarBackButtonHidden(true)
    .navigationDestination(isPresented: $isUserInfoInputViewPresented) {
      /// 사용자 정보 입력 화면으로 이동
      UserInfoInputView(viewModel: viewModel)
    }
  }
}

#Preview {
  ServiceAgreementView()
}
