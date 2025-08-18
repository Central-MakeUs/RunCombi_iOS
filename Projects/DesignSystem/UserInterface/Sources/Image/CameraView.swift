//
//  CameraView.swift
//  UserInterface
//
//  Created by 임경빈 on 8/4/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

public struct CameraView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) private var presentationMode
  let onCapture: (UIImage) -> Void
  
  public init(onCapture: @escaping (UIImage) -> Void) {
    self.onCapture = onCapture
  }
  
  public func makeUIViewController(context: Context) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.delegate = context.coordinator
    picker.cameraCaptureMode = .photo
    picker.videoQuality = .typeHigh
    return picker
  }
  
  public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
  
  public func makeCoordinator() -> Coordinator { Coordinator(self) }
  
  public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: CameraView
    init(_ parent: CameraView) { self.parent = parent }
    
    public func imagePickerController(
      _ picker: UIImagePickerController,
      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
      if let image = info[.originalImage] as? UIImage {
        parent.onCapture(image)
      }
      parent.presentationMode.wrappedValue.dismiss()
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
}
