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
  }
  
  // MARK: - States
  
  struct State {
    var agreementSelections: [AgreementType] = []
  }
  
  // MARK: - Properties
  
  @Published var state = State()
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
    }
  }
}

// MARK: - Event

private extension SignUpViewModel {
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
