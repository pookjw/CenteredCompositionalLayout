//
//  SceneDelegate.swift
//  CenteredCompositionalLayout
//
//  Created by Jinwoo Kim on 6/9/23.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene: UIWindowScene = scene as? UIWindowScene else { return }
    let window: UIWindow = .init(windowScene: windowScene)
    let rootViewController: ViewController = .init()
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    self.window = window
  }
}
