//
//  SignUpViewModel.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import SharedUtility

class SignUpViewModel: ViewModelable {
  
  // MARK: - Actions
  
  enum Action {
    case didTapAgreement(AgreementType)
    case didTapAllAgreement
    case didTapGender(GenderType)
  }
  
  enum NavigationAction {
    case didTapUserInfoInputButton(UserInfoInputType)
    case didTapBackButton(UserInfoInputType)
  }
  
  // MARK: - States
  
  struct State {
    // agreement
    var agreementSelections: [AgreementType] = []
    // userInfo
    var userInfoInputType: UserInfoInputType = .nickname
    var typpedNickname: String = ""
    var selectedGender: GenderType = .none
    var typpedHeight: String = ""
    var typpedWeight: String = ""
  }
  
  // MARK: - Properties
  
  @Published var state = State()
  
  // agreement
  let totalAgreement = AgreementType.allCases.count
  var isAllAgreed: Bool {
    state.agreementSelections.count == totalAgreement
  }
  
  // MARK: - Initialize
  
  init() {
    
  }
  
  // MARK: - Action
  
  func send(action: Action) {
    switch action {
    case .didTapAgreement(let type):
      checkAgreement(type)
    case .didTapAllAgreement:
      checkAllAgreement()
    case .didTapGender(let gender):
      state.selectedGender = gender
    }
  }
  
  func navigate(action: NavigationAction) {
    switch action {
    case .didTapUserInfoInputButton(let type):
      state.userInfoInputType = type
    case .didTapBackButton(let type):
      navigateBack(from: type)
    }
  }
}

// MARK: - Event

private extension SignUpViewModel {
  func navigateBack(from currentType: UserInfoInputType) {
    switch currentType {
    case .nickname:
      break
    case .gender:
      state.userInfoInputType = .nickname
    case .body:
      state.userInfoInputType = .gender
    }
  }
  
  func checkAgreement(_ type: AgreementType) {
    if state.agreementSelections.contains(type) {
      state.agreementSelections.removeAll { $0 == type }
    } else {
      state.agreementSelections.append(type)
    }
  }
  
  func checkAllAgreement() {
    state.agreementSelections = isAllAgreed ? [] : [.terms, .location, .privacy]
  }
}
