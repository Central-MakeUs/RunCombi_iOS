//
//  BottomSheetView.swift
//  UserInterface
//
//  Created by 임경빈 on 7/10/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI
import ResourceKit


public final class BottomSheetPresenter {
  public static let shared = BottomSheetPresenter()
  private var overlayWindow: UIWindow?
  private let animationSpeed: CGFloat = 0.3

  public func show<Content: View>(
    isPresented: Binding<Bool>,
    @ViewBuilder content: @escaping () -> Content
  ) {
    guard overlayWindow == nil else { return }
    // 1) 활성 scene
    guard let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive })
            as? UIWindowScene else { return }

    // 2) 새 윈도우
    let window = UIWindow(windowScene: scene)
    window.windowLevel = .alert
    window.backgroundColor = .clear

    // 3) BottomSheetView 초기화 (일단 false 상태)
    isPresented.wrappedValue = false
    let host = UIHostingController(
      rootView: BottomSheetView(isPresented: isPresented, content: content)
        .background(Color.clear)
    )
    host.view.backgroundColor = .clear
    window.rootViewController = host

    // 4) 윈도우를 보이게만
    window.isHidden = false
    overlayWindow = window

    // 5) 메인 쓰레드 다음 턴에 true로 바꿔서 transition 트리거
    DispatchQueue.main.async {
      withAnimation(.easeOut(duration: self.animationSpeed)) {
        isPresented.wrappedValue = true
      }
    }
  }

  func hide() {
    overlayWindow?.isHidden = true
    overlayWindow = nil
  }
}

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
          .opacity(0.78)
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
        .background(Color(R.color.greyscale_02_252525))
        .padding(.bottom, getSafeArea().bottom)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .zIndex(1)
        .transition(.opacity.combined(with: .move(edge: .bottom)))
        .onDisappear {
          BottomSheetPresenter.shared.hide()
        }
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
