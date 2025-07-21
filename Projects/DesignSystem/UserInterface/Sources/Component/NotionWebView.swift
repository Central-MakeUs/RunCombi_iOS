//
//  NotionWebView.swift
//  UserInterface
//
//  Created by Groonui on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct NotionWebView: View {
  @Environment(\.dismiss) var dismiss
  private let url: String
  
  public init(url: String) {
    self.url = url
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      VStack {
        HStack {
          Button {
            dismiss()
          } label: {
            Image(R.image.backButton)
          }
          Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        
        WebViewRepresentable(url: url)
      }
    }
    .navigationBarBackButtonHidden()
  }
}
