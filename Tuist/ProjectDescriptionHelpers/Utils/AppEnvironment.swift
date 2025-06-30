//
//  AppEnvironment.swift
//  DependencyPlugin
//
//  Created by Junghyun Lee on 3/27/25.
//

import Foundation
import ProjectDescription

public enum AppEnvironment {
  public static let organizationName = "com.Combo"
  public static let projectName: String = "RunCombi"
  public static let appName: String = "런콤비"
  public static let appBundleID = "\(organizationName).\(projectName)"
  public static let destinations: Destinations = [.iPhone]
  public static let infoPlist: InfoPlist = .extendingDefault(
    with: [
      "CFBundleDisplayName": "\(AppEnvironment.appName)",
      "CFBundleIconName": "AppIcon",
      "CFBundleShortVersionString": "0.0",
      "CFBundleVersion": "1",
      "UILaunchScreen": [
        "UIColorName": "",
        "UIImageName": ""
      ]
    ]
  )
}
