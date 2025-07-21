//
//  WebViewRepresentable.swift
//  UserInterface
//
//  Created by Groonui on 7/21/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import WebKit

import ResourceKit

public struct WebViewRepresentable: UIViewRepresentable {
  private var url: String
  
  public init(url: String) {
    self.url = url
  }
  
  public func makeUIView(context: Context) -> WKWebView {
    guard let url = URL(string: url) else {
      return WKWebView()
    }
    let webView = WKWebView()
    webView.isOpaque = false
    webView.backgroundColor = UIColor(Color(R.color.greyscale_01_171717))
    webView.scrollView.backgroundColor = UIColor(Color(R.color.greyscale_01_171717))
    if #available(iOS 13.0, *) {
      webView.overrideUserInterfaceStyle = .dark
    }
    webView.load(URLRequest(url: url))
    
    return webView
  }
  
  public func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WebViewRepresentable>) {
    guard let url = URL(string: url) else { return }
    
    webView.load(URLRequest(url: url))
  }
}
