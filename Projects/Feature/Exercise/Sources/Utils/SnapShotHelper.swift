//
//  SnapShotHelper.swift
//  FeatureExercise
//
//  Created by Groonui on 7/31/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

final class SnapshotHelper {
  static func takeSnapshot(of view: UIView, completion: @escaping (UIImage?) -> Void) {
    DispatchQueue.main.async {
      let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
      let image = renderer.image { ctx in
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
      }
      completion(image)
    }
  }
}

struct SnapshotViewRepresentable<Content: View>: UIViewRepresentable {
  let content: Content
  @Binding var containerRef: UIView?
  
  func makeUIView(context: Context) -> UIView {
    let container = UIViewSnapshotContainer(content: content)
    DispatchQueue.main.async {
      self.containerRef = container
    }
    return container
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {}
}

class UIViewSnapshotContainer<Content: View>: UIView {
  let hostingController: UIHostingController<Content>
  
  init(content: Content) {
    hostingController = UIHostingController(rootView: content)
    super.init(frame: .zero)
    
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addSubview(hostingController.view)
    
    NSLayoutConstraint.activate([
      hostingController.view.topAnchor.constraint(equalTo: topAnchor),
      hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
      hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
      hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
