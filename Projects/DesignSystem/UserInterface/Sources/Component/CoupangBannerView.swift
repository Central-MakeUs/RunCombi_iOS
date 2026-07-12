//
//  CoupangBannerView.swift
//  UserInterface
//
//  Created by Groonui on 2/1/26.
//  Copyright © 2026 com.combo. All rights reserved.
//

import SwiftUI

import Kingfisher
import SharedUtility

public struct CoupangBannerView: View {
  private let bannerURL = URL(string: "https://ads-partners.coupang.com/banners/916900?subId=&traceId=V0-301-7e6e8eb8ddfa1bfb-I916900&w=728&h=90")!
  private let partnerLinkURL = URL(string: "https://link.coupang.com/a/dDOwEg")!
  /// 클릭 이벤트에 함께 기록할 노출 위치 (예: 현재 탭)
  private let placement: String

  public init(placement: String = "unknown") {
    self.placement = placement
  }

  public var body: some View {
    Button {
      AppAnalytics.shared.log(.bannerClick(tab: placement))
      UIApplication.shared.open(partnerLinkURL)
    } label: {
      KFImage(bannerURL)
        .resizable()
        .aspectRatio(728/90, contentMode: .fit)
    }
  }
}
