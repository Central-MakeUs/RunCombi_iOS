//
//  MapOverlayView.swift
//  FeatureExercise
//
//  Created by 임경빈 on 7/17/25.
//  Copyright © 2025 com.combo. All rights reserved.
//

import CoreLocation
import SwiftUI

import ResourceKit
import UserInterface
import SharedUtility

struct MapOverlayView: View {
  @ObservedObject var viewModel: ExerciseViewModel
  @State private var isTest = false
  var body: some View {
    VStack {
      if isTest {
        TrackingPathView()
      }
      
      Spacer()
      Button {
        isTest.toggle()
        //        ExerciseSettingView(viewModel: viewModel)
      } label: {
        Text("운동")
          .giantsFont(size: 24, weight: .regular, lineHeight: 28)
          .foregroundStyle(Color(R.color.greyscale_02_252525))
          .frame(width: 100, height: 100)
          .background(Color(R.color.primary_01_D7FE63))
          .clipShape(.rect(cornerRadius: 4))
      }
      .padding(.bottom, 50)
    }
    .frame(maxWidth: .infinity)
    .background(
      LinearGradient(
        gradient: Gradient(colors: [
          Color(R.color.greyscale_01_171717).opacity(0.99),
          Color(R.color.black_000000).opacity(0),
        ]),
        startPoint: .top,
        endPoint: .bottom
      )
      .frame(height: 350)
      , alignment: .top
    )
  }
}


final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  @Published var locations: [CLLocationCoordinate2D] = []
  @Published var log = ""
  
  private let manager = CLLocationManager()
  
  override init() {
    super.init()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.distanceFilter = 1 // 최소 이동거리 (m)
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
    guard let location = newLocations.last else { return }
    Logger.d("테스트 로그: \(location)")
    log = "테스트 로그: \(location)"
    locations.append(location.coordinate)
  }
}


struct TrackingPathView: View {
  @StateObject private var locationManager = LocationManager()
  
  var body: some View {
    GeometryReader { geo in
      ZStack {
        Color.black.ignoresSafeArea()
        
        VStack {
          Text(locationManager.log)
            .foregroundStyle(.white)
          Spacer()
        }
        Path { path in
          let coords = locationManager.locations
          
          guard !coords.isEmpty else { return }
          
          // 현재 위치를 중심으로 (가장 마지막 위치)
          let ref = coords.last!
          
          func convert(_ coord: CLLocationCoordinate2D) -> CGPoint {
            let dx = (coord.longitude - ref.longitude) * 100_000
            let dy = (coord.latitude - ref.latitude) * 100_000
            
            return CGPoint(
              x: geo.size.width / 2 + dx,
              y: geo.size.height / 2 - dy
            )
          }
          
          path.move(to: convert(coords.first!))
          
          for coord in coords.dropFirst() {
            path.addLine(to: convert(coord))
          }
        }
        .stroke(Color(R.color.primary_01_D7FE63), lineWidth: 3)
        
        // 2. 마지막 위치에 도착지 Circle 추가
        if let last = locationManager.locations.last {
          let ref = last
          let circlePoint = CGPoint(
            x: geo.size.width / 2,
            y: geo.size.height / 2
          )
          
          Circle()
            .fill(Color(R.color.white_FFFDFD))
            .frame(width: 12, height: 12)
            .position(circlePoint)
            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 0)
        }
      }
    }
  }
}
