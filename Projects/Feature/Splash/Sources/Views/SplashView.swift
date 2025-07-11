//
//  SplashView.swift
//  FeatureSplash
//
//  Created by 임경빈 on 7/11/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct SplashView: View {
  @ObservedObject var viewModel = SplashViewModel()
  @Binding private var isSplashPresented: Bool
  
  public init(isSplashPresented: Binding<Bool>) {
    _isSplashPresented = isSplashPresented
  }
  
  public var body: some View {
    VStack {
      Spacer()
      
      Image(R.image.logo)
      
      Spacer()
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .background(Color(R.color.greyscale_01_171717))
    .task {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        viewModel.send(action: .splashDidFinish)
      }
    }
    .onChange(of: viewModel.state.isSplashPresented) {
      if viewModel.state.isSplashPresented == false {
        isSplashPresented = false
      }
    }
  }
}
