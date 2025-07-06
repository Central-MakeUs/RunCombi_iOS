//
//  GIFImage.swift
//  UserInterface
//
//  Created by 임경빈 on 7/6/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct GIFImage: UIViewRepresentable {
  private let path: URL?
  
  public init(path: URL?) {
    self.path = path
  }
  
  public func makeUIView(context: Context) -> UIImageView {
    let imageView = UIImageView()
    
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    
    
    if let path, let data = try? Data(contentsOf: path),
       let source = CGImageSourceCreateWithData(data as CFData, nil) {
      
      var images: [UIImage] = []
      let count = CGImageSourceGetCount(source)
      
      for i in 0..<count {
        if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
          images.append(UIImage(cgImage: cgImage))
        }
      }
      
      let duration = Double(images.count) * 0.03
      imageView.animationImages = images
      imageView.animationDuration = duration
      imageView.startAnimating()
    }
    
    return imageView
  }
  
  public func updateUIView(_ uiView: UIImageView, context: Context) {}
}
