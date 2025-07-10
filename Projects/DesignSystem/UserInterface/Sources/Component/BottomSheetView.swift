//
//  BottomSheetView.swift
//  UserInterface
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import ResourceKit

struct BottomSheetView<Content: View>: View {
  @Binding var isPresented: Bool
  let content: () -> Content
  let animationSpeed: CGFloat = 0.3
  
  @State private var keyboardHeight: CGFloat = 0
  @State private var isKeyboaradActive = false
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if isPresented {
        Color.black
          .opacity(0.6)
          .onTapGesture {
            closeBottomSheet()
          }
        
        VStack(spacing: 0) {
          content()
            .padding(.bottom, getPaddingForSafeArea())
          Rectangle()
            .fill(.white)
            .frame(height: keyboardHeight)
        }
        .background(Color.white)
        .padding(.bottom, getSafeArea().bottom)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .zIndex(1)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
      }
    }
    .ignoresSafeArea(.all)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .animation(.easeOut(duration: animationSpeed), value: isPresented)
    .onAppear {
      addKeyboardNotification()
    }
    .onDisappear {
      removeKeyboardNotification()
    }
  }
  
  func closeBottomSheet() {
    if isKeyboaradActive {
      UIApplication.shared.closeKeyboard()
    }
    withAnimation(.easeIn(duration: animationSpeed)) {
      isPresented = false
    }
  }
}

// MARK: - Keyboard
private extension BottomSheetView {
  func addKeyboardNotification() {
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
      isKeyboaradActive = true
      if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
        withAnimation {
          keyboardHeight = keyboardFrame.height - getSafeArea().bottom
        }
      }
    }
    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
      isKeyboaradActive = false
      withAnimation {
        keyboardHeight = 0
      }
    }
  }
  
  func removeKeyboardNotification() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
}

struct RoundedCorners: Shape {
  var radius: CGFloat = .infinity
  var corners: UIRectCorner = .allCorners
  
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    return Path(path.cgPath)
  }
}
