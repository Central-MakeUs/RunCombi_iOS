//
//  MyPageView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/18/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import ResourceKit
import UserInterface
import SharedUtility

public struct MyPageView: View {
  @EnvironmentObject var userManager: UserManager
  @State private var isEditUserPresented: Bool = false
  @State private var isEditCombiPresented: Bool = false
  @State private var selectedPetID = 0
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
      
      VStack(spacing: 16) {
        HStack(spacing: 16) {
          Spacer()
          
          NavigationLink {
            AlarmView()
          } label: {
            Image(R.image.alarm)
          }
          
          Button {
            path.append("SettingView")
          } label: {
            Image(R.image.setting)
          }
        }
        .padding(.top, 16)
        
        VStack(spacing: 19) {
          if let imageURL = URL(string: userManager.member.profileImgUrl) {
            KFImage(imageURL)
              .resizable()
              .scaledToFill()
              .frame(width: 89, height: 89)
              .clipShape(.rect(cornerRadius: 4))
          } else {
            Image(R.image.person)
          }
          
          VStack(spacing: 12) {
            Text(userManager.member.nickname)
              .pretendardFont(size: 18, weight: .semiBold, lineHeight: 30)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            
            Button {
              /// 내 정보 수정 화면으로 이동
              isEditUserPresented = true
            } label: {
              Text("내 정보 수정")
                .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                .foregroundStyle(Color(R.color.greyscale_05_757575))
                .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
                .background {
                  RoundedRectangle(cornerRadius: 6)
                    .fill(.clear)
                    .stroke(Color(R.color.greyscale_05_757575), lineWidth: 0.6)
                }
            }
          }
        }
        .padding(.top, 32)
        
        HStack(spacing: 12) {
          if userManager.petList.count > 1 {
            ForEach(userManager.petList, id: \.self) { pet in
              EditCombiButton(combiID: pet.petId) {
                /// 콤비 수정 화면으로 이동
                selectedPetID = pet.petId
                isEditCombiPresented = true
              }
            }
          } else {
            let combiID = (userManager.petList.first?.petId).ifNil(then: 0)
            EditCombiButton(combiID: combiID) {
              /// 콤비 수정 화면으로 이동
              selectedPetID = combiID
              isEditCombiPresented = true
            }
            AddCombiButton(snackBarItem: $snackBarItem)
          }
        }
        .padding(.top, 40)
        
        Spacer()
      }
      .padding(.horizontal, 20)
    }
    .fullScreenCover(isPresented: $isEditUserPresented) {
      EditUserProfileView()
    }
    .fullScreenCover(isPresented: $isEditCombiPresented) {
      EditCombiProfileView(combiID: $selectedPetID)
    }
    .overlay(
      Group {
        if snackBarItem.isEmpty == false {
          HStack {
            Image(R.image.checkBox)
            Text(snackBarItem)
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(Color(R.color.white_FFFFFF))
            Spacer()
          }
          .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
          .background(Color(R.color.greyscale_04_525252))
          .clipShape(.rect(cornerRadius: 8))
          .transition(.move(edge: .top).combined(with: .opacity))
          .task {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
              withAnimation {
                snackBarItem = ""
              }
            }
          }
        }
      }
      .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)), alignment: .top
    )
  }
}
