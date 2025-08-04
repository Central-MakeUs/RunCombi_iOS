//
//  DetailMenuView.swift
//  FeatureRecord
//
//  Created by 임경빈 on 8/2/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainCalendar
import ResourceKit
import SharedUtility
import UserInterface

struct DetailMenuView: View {
  @Dependency(\.calendarClient) var calendarClient

  @Binding var isMenuPresented: Bool
  @Binding var isDeleteRecordSheetPresented: Bool
  @Binding var isSelectImageSheetPresented: Bool
  @Binding var runDetail: RunDetail
  @Binding var selectedImageData: Data?
  
  @State private var isEditRecordViewPresented: Bool = false
  
  var body: some View {
    ZStack(alignment: .top) {
      Color(R.color.black_212121)
        .opacity(0.76)
        .ignoresSafeArea()
        .onTapGesture {
          withAnimation {
            isMenuPresented = false
          }
        }
      
      HStack {
        Spacer()
        VStack(alignment: .trailing, spacing: 10) {
          Button {
            withAnimation {
              isMenuPresented = false
            }
          } label: {
            Image(R.image.menu)
          }
          
          VStack(spacing: 12) {
            Button {
              isEditRecordViewPresented = true
            } label: {
              HStack(spacing: 12) {
                Image(R.image.pencil)
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 16, height: 16)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                
                Text("기록 편집")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              }
            }
            
            Button {
              isSelectImageSheetPresented = true
            } label: {
              HStack(spacing: 12) {
                Image(R.image.album)
                  .resizable()
                  .renderingMode(.template)
                  .frame(width: 16, height: 16)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                
                Text(runDetail.runImageUrl.isEmpty && selectedImageData == nil ? "사진 추가" : "사진 변경")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              }
            }
            
            Button {
              isDeleteRecordSheetPresented = true
            } label: {
              HStack(spacing: 12) {
                Image(R.image.trash)
                  .resizable()
                  .frame(width: 16, height: 16)
                
                Text("기록 삭제")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.red_B04A4A))
              }
            }
          }
          .padding(EdgeInsets(top: 20, leading: 16, bottom: 16, trailing: 16))
          .background(Color(R.color.greyscale_02_252525))
          .clipShape(.rect(cornerRadius: 6))
          .contentShape(.rect)
        }
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
      .fullScreenCover(isPresented: $isEditRecordViewPresented) {
        EditRecordView(runDetail: $runDetail)
      }
    }
  }
}
