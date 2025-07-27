//
//  SelectImageView.swift
//  UserInterface
//
//  Created by Groonui on 7/14/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import PhotosUI
import SwiftUI

import ResourceKit

public enum ImageType {
  case user
  case dog
}

private extension ImageType {
  var placeholder: Image {
    switch self {
    case .user:
      Image(R.image.person)
    case .dog:
      Image(R.image.dog)
    }
  }
  
  var uiImage: UIImage? {
    switch self {
    case .user:
      R.image.person()
    case .dog:
      R.image.dog()
    }
  }
}

public struct SelectImageView: View {
  private let type: ImageType
  @State private var isPhotosPickerPresented: Bool = false
  @State private var selectedPicture: PhotosPickerItem?
  @Binding private var selectedImageData: Data?
  
  public init(type: ImageType, selectedImageData: Binding<Data?>) {
    self.type = type
    self._selectedImageData = selectedImageData
  }
  
  public var body: some View {
    Button {
      isPhotosPickerPresented = true
    } label: {
      if let data = selectedImageData,
         let uiImage = UIImage(data: data) {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFill()
          .frame(width: 90, height: 90)
          .clipShape(.rect(cornerRadius: 4))
      } else {
        type.placeholder
          .frame(width: 89, height: 89)
          .onAppear {
            if let uiImage = type.uiImage {
              self.selectedImageData = uiImage.pngData()
            }
          }
      }
    }
    .overlay(alignment: .bottomTrailing) {
      Image(R.image.overlayCamera)
        .padding(.bottom, -12)
        .padding(.trailing, -16)
    }
    .photosPicker(
      isPresented: $isPhotosPickerPresented,
      selection: $selectedPicture,
      matching: .all(of: [.not(.videos)])
    )
    .onChange(of: selectedPicture) {
      Task {
        // PhotosPickerItem에서 Data 타입으로 로드
        if let data = try? await selectedPicture?.loadTransferable(type: Data.self) {
          // 메인 스레드에서 상태 업데이트
          await MainActor.run {
            selectedImageData = data
          }
        }
      }
    }
  }
}
