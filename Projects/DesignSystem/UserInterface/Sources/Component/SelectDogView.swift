//
//  SelectDogView.swift
//  UserInterface
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import ResourceKit
import SharedUtility

public struct SelectDogView: View {
  @EnvironmentObject var userManager: UserManager
  @Binding var selectedPets: [Pet]
  
  public init(selectedPets: Binding<[Pet]>) {
    self._selectedPets = selectedPets
  }
  
  public var body: some View {
    VStack(spacing: 16) {
      HStack(alignment: .top, spacing: .zero) {
        Image(R.image.exercisePerson)
          .overlay(alignment: .leading) {
            if let profileImgURL = URL(string: userManager.member.profileImgUrl) {
              KFImage(profileImgURL)
                .resizable()
                .frame(width: 57, height: 57)
                .clipShape(DiagonalCutShape(cutSize: CGSize(width: 7, height: 11)))
                .clipShape(.rect(cornerRadius: 2))
                .padding(.leading, 6)
            }
          }
        
        if userManager.petList.count > 1,
           let firstPet = userManager.petList.first,
           let secondPet = userManager.petList.last {
          Button {
            if let index = selectedPets.firstIndex(where: { $0.petId == firstPet.petId }) {
              selectedPets.remove(at: index)
            } else {
              selectedPets.append(firstPet)
            }
          } label: {
            VStack(spacing: 16) {
              if let petImageURL = URL(string: firstPet.petImageUrl) {
                Image(R.image.dogBackground2)
                  .renderingMode(.template)
                  .foregroundStyle(selectedPets.contains(firstPet) ? Color(R.color.primary_02_E8FFA3) : Color(R.color.greyscale_06_999999))
                  .overlay {
                    KFImage(petImageURL)
                      .resizable()
                      .frame(width: 57, height: 57)
                      .clipShape(DiagonalCutShape(cutSize: CGSize(width: 7, height: 11)))
                      .clipShape(.rect(cornerRadius: 2))
                  }
              } else {
                Image(R.image.exerciseDog2)
                  .renderingMode(.template)
                  .foregroundStyle(selectedPets.contains(firstPet) ? Color(R.color.primary_02_E8FFA3) : Color(R.color.greyscale_06_999999))
                  .overlay {
                    Image(R.image.dogPlaceholder)
                  }
              }
              
              if selectedPets.isEmpty {
                Text(firstPet.name)
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(selectedPets.isEmpty ? Color(R.color.greyscale_06_999999) : Color(R.color.primary_01_D7FE63))
              }
            }
          }
          
          Button {
            if let index = selectedPets.firstIndex(where: { $0.petId == secondPet.petId }) {
              selectedPets.remove(at: index)
            } else {
              selectedPets.append(secondPet)
            }
          } label: {
            VStack(spacing: 16) {
              if let petImageURL = URL(string: secondPet.petImageUrl) {
                Image(R.image.dogBackground1)
                  .renderingMode(.template)
                  .foregroundStyle(selectedPets.contains(secondPet) ? Color(R.color.primary_02_E8FFA3) : Color(R.color.greyscale_06_999999))
                  .overlay(alignment: .trailing) {
                    KFImage(petImageURL)
                      .resizable()
                      .frame(width: 57, height: 57)
                      .clipShape(DiagonalCutShape(cutSize: CGSize(width: 7, height: 11)))
                      .clipShape(.rect(cornerRadius: 2))
                      .padding(.trailing, 6)
                  }
              } else {
                Image(R.image.dogBackground1)
                  .renderingMode(.template)
                  .foregroundStyle(selectedPets.contains(secondPet) ? Color(R.color.primary_02_E8FFA3) : Color(R.color.greyscale_06_999999))
                  .overlay(alignment: .trailing) {
                    Image(R.image.dogPlaceholder)
                      .padding(.trailing, 6)
                  }
              }
              
              if selectedPets.isEmpty {
                Text(secondPet.name)
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(Color(R.color.greyscale_06_999999))
                  .padding(.leading, 6)
              }
            }
          }
        } else if let firstPet = userManager.petList.first {
          Button {
            selectedPets = [firstPet]
          } label: {
            VStack(spacing: 16) {
              if let petImageURL = URL(string: firstPet.petImageUrl) {
                Image(R.image.dogBackground1)
                  .renderingMode(.template)
                  .foregroundStyle(selectedPets.contains(firstPet) ? Color(R.color.primary_02_E8FFA3) : Color(R.color.greyscale_06_999999))
                  .overlay(alignment: .trailing) {
                    KFImage(petImageURL)
                      .resizable()
                      .frame(width: 57, height: 57)
                      .clipShape(DiagonalCutShape(cutSize: CGSize(width: 7, height: 11)))
                      .clipShape(.rect(cornerRadius: 2))
                      .padding(.trailing, 6)
                  }
              } else {
                Image(R.image.dogBackground1)
                  .renderingMode(.template)
                  .foregroundStyle(selectedPets.contains(firstPet) ? Color(R.color.primary_02_E8FFA3) : Color(R.color.greyscale_06_999999))
                  .overlay(alignment: .trailing) {
                    Image(R.image.dogPlaceholder)
                      .padding(.trailing, 6)
                  }
              }
              if selectedPets.isEmpty {
                Text(firstPet.name)
                  .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
                  .foregroundStyle(selectedPets.contains(firstPet) ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_06_999999))
                  .padding(.leading, 6)
              }
            }
          }
        }
      }
      
      if !selectedPets.isEmpty {
        HStack {
          if userManager.petList.count > 1,
             let firstPet = userManager.petList.first,
             let secondPet = userManager.petList.last {
            Text(selectedPets.contains(firstPet) && selectedPets.contains(secondPet) ? "\(firstPet.name), \(secondPet.name)\(secondPet.name.isLetterWithBase()) 함께!" : selectedPets.contains(firstPet) ? "\(firstPet.name)\(firstPet.name.isLetterWithBase()) 함께!" : selectedPets.contains(secondPet) ? "\(secondPet.name)\(secondPet.name.isLetterWithBase()) 함께!" : "")
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(selectedPets.isEmpty ? Color(R.color.greyscale_06_999999) : Color(R.color.primary_01_D7FE63))
          } else if let firstPet = userManager.petList.first {
            Text(selectedPets.contains(firstPet) ? "\(firstPet.name)\(firstPet.name.isLetterWithBase()) 함께!" : "")
              .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
              .foregroundStyle(selectedPets.contains(firstPet) ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_06_999999))
              .padding(.leading, 6)
          }
        }
      }
    }
  }
}
