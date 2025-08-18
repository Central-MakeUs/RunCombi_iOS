//
//  AppVersionSection.swift
//  FeatureMyPage
//
//  Created by 임경빈 on 7/26/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import Dependencies
import DomainMyPage
import ResourceKit
import SharedUtility

struct AppVersionSection: View {
  @Dependency(\.myPageClient) var myPageClient
  let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
  @State private var isUpdateRequired = false
  
  var body: some View {
    HStack {
      HStack(alignment: .bottom, spacing: 8) {
        Text("앱 버전")
          .pretendardFont(size: 16, weight: .medium, lineHeight: 26)
          .foregroundStyle(Color(R.color.ff_F4F4F4))
        
        Text("v.\(appVersion)")
          .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
          .foregroundStyle(Color(R.color.greyscale_06_999999))
      }
      Spacer()
      
      Button {
        openAppStore(urlStr: "itms-apps://itunes.apple.com/app/apple-store/6747975586")
      } label: {
        Text("업데이트")
          .pretendardFont(size: 12, weight: .semiBold, lineHeight: 22)
          .foregroundStyle(Color(R.color.black_000000))
          .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
          .background(isUpdateRequired ? Color(R.color.primary_01_D7FE63) : Color(R.color.greyscale_03_333333))
          .clipShape(.rect(cornerRadius: 2))
      }
      .disabled(!isUpdateRequired)
    }
    .task {
      await checkVersion()
    }
  }
  
  private func checkVersion() async {
    do {
      isUpdateRequired = try await myPageClient.checkVersion(version: appVersion)
    } catch {
      Logger.e("\(error)")
    }
  }
  
  private func openAppStore(urlStr: String) -> Result<Void, AppstoreOpenError> {
    guard let url = URL(string: urlStr) else {
      Logger.e("invalid app store url")
      return .failure(.invalidAppStoreURL)
    }
    
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
      return .success(())
    } else {
      Logger.e("can't open app store url")
      return .failure(.cantOpenAppStoreURL)
    }
  }
}

enum AppstoreOpenError: Error {
  case invalidAppStoreURL
  case cantOpenAppStoreURL
}
