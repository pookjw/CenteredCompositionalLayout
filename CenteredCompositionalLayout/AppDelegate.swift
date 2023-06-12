//
//  AppDelegate.swift
//  CenteredCompositionalLayout
//
//  Created by Jinwoo Kim on 6/9/23.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    let configuration: UISceneConfiguration = connectingSceneSession.configuration
    configuration.delegateClass = SceneDelegate.self
    return configuration
  }
}
