//
//  CropBoxView.swift
//  UserInterface
//
//  Created by 임경빈 on 9/1/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import SwiftUI

import ResourceKit

public struct CropBoxView: View {
  @Binding public var selectedImageData: Data?
  let action: () -> Void
  
  @State var cropArea: CGRect = .init(x: 0, y: 0, width: 200, height: 150)
  @State var imageViewSize: CGSize = .zero
  
  public init(selectedImageData: Binding<Data?>, action: @escaping () -> Void) {
    self._selectedImageData = selectedImageData
    self.action = action
  }
  
  public var body: some View {
    ZStack {
      Color(R.color.greyscale_01_171717)
        .ignoresSafeArea()
      
      if let selectedImageData,
         let image = UIImage(data: selectedImageData) {
        Image(uiImage: image)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
          .overlay(alignment: .topLeading) {
            GeometryReader { geometry in
              CropBox(rect: $cropArea)
                .onAppear {
                  self.imageViewSize = geometry.size
                }
                .onChange(of: geometry.size) { _, newValue in
                  self.imageViewSize = newValue
                }
            }
          }
        
        VStack {
          Spacer()
          Button {
            self.selectedImageData = self.crop(
              image: image,
              cropArea: cropArea,
              imageViewSize: imageViewSize
            )?.pngData()
            action()
          } label: {
            PrimaryActionLabel(
              text: "완료",
              backgroundColor: Color(R.color.primary_01_D7FE63)
            )
          }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, getSafeArea().bottom)
        .padding(.bottom)
      }
    }
  }
  
  private func crop(image: UIImage, cropArea: CGRect, imageViewSize: CGSize) -> UIImage? {
    let baseImage = image.normalizedUp()
    guard let cg = baseImage.cgImage else { return nil }
    
    let scaleX = baseImage.size.width / imageViewSize.width
    let scaleY = baseImage.size.height / imageViewSize.height
    
    let scaledCropArea = CGRect(
      x: cropArea.origin.x * scaleX,
      y: cropArea.origin.y * scaleY,
      width: cropArea.size.width * scaleX,
      height: cropArea.size.height * scaleY
    )
    
    guard let cut = cg.cropping(to: scaledCropArea) else { return nil }
    return UIImage(cgImage: cut, scale: baseImage.scale, orientation: .up)
  }
}

struct CropBox: View {
  @Binding public var rect: CGRect
  public let minSize: CGSize
  
  @State private var initialRect: CGRect? = nil
  @State private var frameSize: CGSize = .zero
  @State private var draggedCorner: UIRectCorner? = nil
  
  public init(
    rect: Binding<CGRect>,
    minSize: CGSize = .init(width: 100, height: 100)
  ) {
    self._rect = rect
    self.minSize = minSize
  }
  
  private var rectDrag: some Gesture {
    DragGesture()
      .onChanged { gesture in
        if initialRect == nil {
          initialRect = rect
          draggedCorner = closestCorner(point: gesture.startLocation, rect: rect)
        }
        
        if let draggedCorner {
          self.rect = dragResize(
            initialRect: initialRect!,
            draggedCorner: draggedCorner,
            frameSize: frameSize,
            translation: gesture.translation
          )
        } else {
          self.rect = drag(
            initialRect: initialRect!,
            frameSize: frameSize,
            translation: gesture.translation
          )
        }
      }
      .onEnded { gesture in
        initialRect = nil
        draggedCorner = nil
      }
  }
  
  public var body: some View {
    ZStack(alignment: .topLeading) {
      blur
      box
    }
    .background {
      GeometryReader { geometry in
        Color.clear
          .onAppear {
            self.frameSize = geometry.size
          }
          .onChange(of: geometry.size) { _, newValue in
            self.frameSize = newValue
          }
      }
    }
  }
  
  private var blur: some View {
    Color.black.opacity(0.5)
      .overlay(alignment: .topLeading) {
        Color.white
          .frame(width: rect.width - 1, height: rect.height - 1)
          .offset(x: rect.origin.x, y: rect.origin.y)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .drawingGroup()
      .blendMode(.multiply)
  }
  
  private var box: some View {
    ZStack {
      grid
      pins
    }
    .border(Color(R.color.primary_01_D7FE63), width: 2)
    .background(Color.white.opacity(0.001))
    .frame(width: rect.width, height: rect.height)
    .offset(x: rect.origin.x, y: rect.origin.y)
    .gesture(rectDrag)
  }
  
  private var pins: some View {
    VStack {
      HStack {
        pin(corner: .topLeft)
        Spacer()
        pin(corner: .topRight)
      }
      Spacer()
      HStack {
        pin(corner: .bottomLeft)
        Spacer()
        pin(corner: .bottomRight)
      }
    }
  }
  
  private func pin(corner: UIRectCorner) -> some View {
    var offX = 1.0
    var offY = 1.0
    
    switch corner {
    case .topLeft:      offX = -1;  offY = -1
    case .topRight:                 offY = -1
    case .bottomLeft:   offX = -1
    case .bottomRight: break
    default: break
    }
    
    return Circle()
      .fill(Color(R.color.primary_01_D7FE63))
      .frame(width: 16, height: 16)
      .offset(x: offX * 8, y: offY * 8)
  }
  
  private var grid: some View {
    ZStack {
      HStack {
        Spacer()
        Rectangle()
          .frame(width: 1)
          .frame(maxHeight: .infinity)
        Spacer()
        Rectangle()
          .frame(width: 1)
          .frame(maxHeight: .infinity)
        Spacer()
      }
      VStack {
        Spacer()
        Rectangle()
          .frame(height: 1)
          .frame(maxWidth: .infinity)
        Spacer()
        Rectangle()
          .frame(height: 1)
          .frame(maxWidth: .infinity)
        Spacer()
      }
    }
    .foregroundColor(.gray)
  }
  
  private func closestCorner(point: CGPoint, rect: CGRect, distance: CGFloat = 16) -> UIRectCorner? {
    let ldX = abs(rect.minX.distance(to: point.x)) < distance
    let rdX = abs(rect.maxX.distance(to: point.x)) < distance
    let tdY = abs(rect.minY.distance(to: point.y)) < distance
    let bdY = abs(rect.maxY.distance(to: point.y)) < distance
    
    guard (ldX || rdX) && (tdY || bdY) else { return nil }
    
    return if ldX && tdY { .topLeft }
    else if rdX && tdY { .topRight }
    else if ldX && bdY { .bottomLeft }
    else if rdX && bdY { .bottomRight }
    else { nil }
  }
  
  /// 4:3 등 고정 종횡비로 리사이즈
  private func dragResize(
    initialRect: CGRect,
    draggedCorner: UIRectCorner,
    frameSize: CGSize,
    translation: CGSize,
    aspect: CGFloat = 4.0/3.0   // ← 기본 4:3
  ) -> CGRect {
    
    // 1) 드래그 코너에 따라 앵커(반대편 코너) 고정
    let anchorTL = CGPoint(x: initialRect.minX, y: initialRect.minY)
    let anchorTR = CGPoint(x: initialRect.maxX, y: initialRect.minY)
    let anchorBL = CGPoint(x: initialRect.minX, y: initialRect.maxY)
    let anchorBR = CGPoint(x: initialRect.maxX, y: initialRect.maxY)
    
    // 드래그된 코너의 "제안 위치"
    var proposedX: CGFloat = 0
    var proposedY: CGFloat = 0
    var anchor: CGPoint = .zero
    
    switch draggedCorner {
    case .topLeft:
      proposedX = initialRect.minX + translation.width
      proposedY = initialRect.minY + translation.height
      anchor    = anchorBR
    case .topRight:
      proposedX = initialRect.maxX + translation.width
      proposedY = initialRect.minY + translation.height
      anchor    = anchorBL
    case .bottomLeft:
      proposedX = initialRect.minX + translation.width
      proposedY = initialRect.maxY + translation.height
      anchor    = anchorTR
    case .bottomRight:
      proposedX = initialRect.maxX + translation.width
      proposedY = initialRect.maxY + translation.height
      anchor    = anchorTL
    default:
      return initialRect
    }
    
    // 2) 우선 "자유 비율"로 폭/높이를 제안하고,
    //    변화량이 큰 축을 기준으로 다른 축을 aspect로 맞춤
    var wFree: CGFloat
    var hFree: CGFloat
    
    switch draggedCorner {
    case .topLeft, .bottomLeft:
      wFree = abs(anchor.x - proposedX)
    default:
      wFree = abs(proposedX - anchor.x)
    }
    switch draggedCorner {
    case .topLeft, .topRight:
      hFree = abs(anchor.y - proposedY)
    default:
      hFree = abs(proposedY - anchor.y)
    }
    
    let dw = abs(wFree - initialRect.width)
    let dh = abs(hFree - initialRect.height)
    
    var w: CGFloat
    var h: CGFloat
    if dw >= dh {
      // width 우선 → height = width / aspect
      w = max(wFree, minSize.width)
      h = max(w / aspect, minSize.height)
    } else {
      // height 우선 → width = height * aspect
      h = max(hFree, minSize.height)
      w = max(h * aspect, minSize.width)
    }
    
    // 3) 드래그 코너 방향으로 배치(앵커는 고정)
    var minX: CGFloat = 0, minY: CGFloat = 0, maxX: CGFloat = 0, maxY: CGFloat = 0
    switch draggedCorner {
    case .topLeft:
      maxX = anchor.x; maxY = anchor.y
      minX = maxX - w; minY = maxY - h
    case .topRight:
      minX = anchor.x; maxY = anchor.y
      maxX = minX + w; minY = maxY - h
    case .bottomLeft:
      maxX = anchor.x; minY = anchor.y
      minX = maxX - w; maxY = minY + h
    case .bottomRight:
      minX = anchor.x; minY = anchor.y
      maxX = minX + w; maxY = minY + h
    default:
      break
    }
    
    // 4) 프레임 경계 내로 비율 유지 클램프
    let clampMinX: CGFloat = 0, clampMinY: CGFloat = 0
    let clampMaxX: CGFloat = frameSize.width, clampMaxY: CGFloat = frameSize.height
    
    // 앵커는 고정이므로, 드래그된 쪽이 경계를 넘으면 w/h를 줄여서 맞춘다
    // corner마다 허용 가능한 최대 폭/높이를 계산
    var maxWByBounds: CGFloat
    var maxHByBounds: CGFloat
    
    switch draggedCorner {
    case .topLeft:
      maxWByBounds = anchor.x - clampMinX
      maxHByBounds = anchor.y - clampMinY
    case .topRight:
      maxWByBounds = clampMaxX - anchor.x
      maxHByBounds = anchor.y - clampMinY
    case .bottomLeft:
      maxWByBounds = anchor.x - clampMinX
      maxHByBounds = clampMaxY - anchor.y
    case .bottomRight:
      maxWByBounds = clampMaxX - anchor.x
      maxHByBounds = clampMaxY - anchor.y
    default:
      maxWByBounds = w; maxHByBounds = h
    }
    
    // 비율을 유지하며 경계 내 최대 크기 산출
    // (가로 제한, 세로 제한 두 조건 중 더 빡센 쪽을 택함)
    let wLimitByW = maxWByBounds
    let wLimitByH = maxHByBounds * aspect
    let wMax = min(wLimitByW, wLimitByH)
    
    let hLimitByH = maxHByBounds
    let hLimitByW = maxWByBounds / aspect
    let hMax = min(hLimitByH, hLimitByW)
    
    // 현재 w/h를 경계 내로 줄이기
    w = min(w, wMax)
    h = min(h, hMax)
    
    // 최종적으로 한 번 더 aspect 정렬
    if dw >= dh {
      h = w / aspect
    } else {
      w = h * aspect
    }
    
    // 다시 corner 기준으로 좌표 재계산
    switch draggedCorner {
    case .topLeft:
      maxX = anchor.x; maxY = anchor.y
      minX = maxX - w; minY = maxY - h
    case .topRight:
      minX = anchor.x; maxY = anchor.y
      maxX = minX + w; minY = maxY - h
    case .bottomLeft:
      maxX = anchor.x; minY = anchor.y
      minX = maxX - w; maxY = minY + h
    case .bottomRight:
      minX = anchor.x; minY = anchor.y
      maxX = minX + w; maxY = minY + h
    default:
      break
    }
    
    return CGRect(x: minX, y: minY, width: w, height: h)
  }
  
  private func drag(initialRect: CGRect, frameSize: CGSize, translation: CGSize) -> CGRect {
    let maxX = frameSize.width - initialRect.width
    let newX = min(max(initialRect.origin.x + translation.width, 0), maxX)
    let maxY = frameSize.height - initialRect.height
    let newY = min(max(initialRect.origin.y + translation.height, 0), maxY)
    
    return .init(origin: .init(x: newX, y: newY), size: initialRect.size)
  }
}
