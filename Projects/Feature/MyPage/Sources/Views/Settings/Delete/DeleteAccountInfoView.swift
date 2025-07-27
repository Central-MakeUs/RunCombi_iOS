//
//  DeleteAccountInfoView.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit
import UserInterface

struct DeleteAccountInfoView: View {
  @Environment(\.dismiss) var dismiss
  
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
        VStack(spacing: 45) {
          VStack(spacing: 4) {
            Text("정말 런콤비를\n떠나시는 건가요?")
              .pretendardFont(size: 24, weight: .semiBold, lineHeight: 36)
              .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
              .frame(maxWidth: .infinity, alignment: .leading)
            Text("콤비와 함께한 추억들이 모두 사라져요.")
              .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
              .foregroundStyle(Color(R.color.greyscale_08_EDEDED).opacity(0.72))
              .frame(maxWidth: .infinity, alignment: .leading)
          }
          
          VStack(spacing: 32) {
            VStack(spacing: 16) {
              HStack {
                Text("등록된 콤비")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                Spacer()
                Text("초코")
                  .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                  .foregroundStyle(Color(R.color.primary_02_E8FFA3))
              }
              .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
              .background(Color(R.color.greyscale_02_252525))
              .clipShape(.rect(cornerRadius: 4))
              
              HStack {
                Text("저장된 운동 기록")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                Spacer()
                Text("71개")
                  .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                  .foregroundStyle(Color(R.color.primary_02_E8FFA3))
              }
              .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
              .background(Color(R.color.greyscale_02_252525))
              .clipShape(.rect(cornerRadius: 4))
              
              HStack {
                Text("저장된 사진")
                  .pretendardFont(size: 14, weight: .medium, lineHeight: 24)
                  .foregroundStyle(Color(R.color.greyscale_08_EDEDED))
                Spacer()
                Text("17장")
                  .giantsFont(size: 12, weight: .regular, lineHeight: 14)
                  .foregroundStyle(Color(R.color.primary_02_E8FFA3))
              }
              .padding(EdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16))
              .background(Color(R.color.greyscale_02_252525))
              .clipShape(.rect(cornerRadius: 4))
            }
            
            VStack(spacing: 8) {
              Text("· 삭제된 데이터는 재가입시에도 복구되지 않으니,\n  신중하게 고민해주세요.")
                .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED).opacity(0.56))
                .frame(maxWidth: .infinity, alignment: .leading)
              Text("· 동일한 계정으로는 24시간 후 재가입이 가능해요.")
                .pretendardFont(size: 12, weight: .regular, lineHeight: 22)
                .foregroundStyle(Color(R.color.greyscale_08_EDEDED).opacity(0.56))
                .frame(maxWidth: .infinity, alignment: .leading)
            }
          }
        }
        Spacer()
        
        NavigationLink {
          DeleteAccountActionView()
        } label: {
          PrimaryActionLabel(text: "다음", foregroundColor: Color(R.color.greyscale_03_333333), backgroundColor: Color(R.color.primary_01_D7FE63))
        }
      }
    }
    .padding(.horizontal, 20)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(R.color.greyscale_01_171717).ignoresSafeArea())
    .navigationBarBackButtonHidden()
  }
}

#Preview {
  DeleteAccountInfoView()
}
