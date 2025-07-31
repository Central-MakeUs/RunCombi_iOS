//
//  RecordDetailHeader.swift
//  FeatureRecord
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import DomainCalendar
import ResourceKit

struct RecordDetailHeader: View {
  @Environment(\.dismiss) var dismiss
  @Binding var runDetail: RunDetail

  var body: some View {
    ZStack(alignment: .top) {
      Color(R.color.greyscale_02_252525)
      
      if runDetail.routeImageUrl.isEmpty == false {
        
      } else if runDetail.runImageUrl.isEmpty == false {
        
      } else {
        VStack(spacing: 52) {
          Text("찍은 운동 사진이 없어요,,,")
            .giantsFont(size: 18, weight: .regular, lineHeight: 26)
            .foregroundStyle(Color(R.color.greyscale_04_525252))
          
          Button {
            // TODO: - 사진 추가
          } label: {
            HStack(spacing: 8) {
              Image(R.image.album)
              Text("사진 추가하기")
                .pretendardFont(size: 18, weight: .semiBold, lineHeight: 21)
                .foregroundStyle(Color(R.color.greyscale_06_999999))
            }
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(Color(R.color.greyscale_03_333333))
            .clipShape(.rect(cornerRadius: 6))
          }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
      }
      HStack(spacing: 8) {
        Button {
          dismiss()
        } label: {
          Image(R.image.backButton)
        }
        
        Text((runDetail.regDate.toKoreanDateFormat()).ifNil(then: ""))
          .pretendardFont(size: 14, weight: .semiBold, lineHeight: 26)
          .foregroundStyle(Color(R.color.white_FFFFFF))
        
        Spacer()
        
        Button {
          // TODO: - Menu 기능
        } label: {
          Image(R.image.menu)
        }
      }
      .padding(.top, 16)
      .padding(.horizontal, 20)
    }
    .frame(height: 264)
  }
}
