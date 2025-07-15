//
//  SignUpViewModel.swift
//  FeatureSignUp
//
//  Created by 임경빈 on 7/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import Foundation

import Dependencies
import DomainLogin
import DomainSignUp
import SharedUtility

class SignUpViewModel: ViewModelable {
  
  // MARK: - Injections
  
  @Dependency(\.loginClient) var loginClient
  @Dependency(\.signUpClient) var signUpClient
  
  // MARK: - Actions
  
  enum Action {
    case didTapAgreement(AgreementType)
    case didTapAllAgreement
    case didTapNextInAgreement
    case didTapGender(GenderType)
    case didTapWalkStyle(WalkStyleType)
  }
  
  enum NavigationAction {
    case didTapUserInfoInputButton(UserInfoInputType)
    case didTapUserInfoBackButton(UserInfoInputType)
    case didTapDogInfoInputButton(DogInfoInputType)
    case didTapDogInfoBackButton(DogInfoInputType)
  }
  
  // MARK: - States
  
  struct State {
    // agreement
    var agreementSelections: [AgreementType] = []
    var isUserInfoInputViewPresented = false
    // userInfo
    var userInfoInputType: UserInfoInputType = .nickname
    var selectedUserImageData: Data?
    var typpedNickname: String = ""
    var selectedGender: GenderType = .none
    var typpedHeight: String = ""
    var typpedWeight: String = ""
    // dogInfo
    var dogInfoInputType: DogInfoInputType = .name
    var selectedDogImageData: Data?
    var typpedDogName: String = ""
    var typpedDogAge: String = ""
    var typpedDogWeight: String = ""
    var selectedWalkStyle: WalkStyleType = .none
    // completed
    var isMoreDogSheetPresented = false
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
    case .didTapNextInAgreement:
      Task { await setMemberTerms() }
    case .didTapGender(let gender):
      state.selectedGender = gender
    case .didTapWalkStyle(let walkStyle):
      state.selectedWalkStyle = walkStyle
    }
  }
  
  func navigate(action: NavigationAction) {
    switch action {
    case .didTapUserInfoInputButton(let type):
      state.userInfoInputType = type
    case .didTapUserInfoBackButton(let type):
      navigateUserInfoBack(from: type)
    case .didTapDogInfoInputButton(let type):
      state.dogInfoInputType = type
    case .didTapDogInfoBackButton(let type):
      navigateDogInfoBack(from: type)
    }
  }
}

// MARK: - Event

private extension SignUpViewModel {
  func navigateUserInfoBack(from currentType: UserInfoInputType) {
    switch currentType {
    case .nickname:
      break
    case .gender:
      state.userInfoInputType = .nickname
    case .body:
      state.userInfoInputType = .gender
    }
  }
  
  func navigateDogInfoBack(from currentType: DogInfoInputType) {
    switch currentType {
    case .name:
      break
    case .body:
      state.dogInfoInputType = .name
    case .walkStyle:
      state.dogInfoInputType = .body
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
  
  @MainActor
  func setMemberTerms() async {
    do {
      let token = TokenManager.shared.accessToken.ifNil(then: "")
      try await signUpClient.setMemberTerms(token: token)
      let memberDetail = try await loginClient.getMemberDetail(token: token)
      if memberDetail.memberStatus == .pendingMemberDetail {
        state.isUserInfoInputViewPresented = true
      } else {
        throw ServerError.serverError
      }
    } catch {
      Logger.e("\(error)")
    }
  }
}
