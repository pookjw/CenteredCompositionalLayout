//
//  ContentView.swift
//  DynamicFlowLayout
//
//  Created by Jinwoo Kim on 5/25/23.
//

import UIKit

struct ContentConfiguration: UIContentConfiguration {
  let text: String

  @MainActor func makeContentView() -> UIView & UIContentView {
    ContentView(configuration: self)
  }

  func updated(for state: UIConfigurationState) -> ContentConfiguration {
    self
  }
}

@MainActor
final class ContentView: UIView {
  private var textLabel: UILabel!
  private var _configuration: ContentConfiguration {
    didSet {
      textLabel.text = _configuration.text
      backgroundColor = .init(red: .random(in: 0...1.0), green:  .random(in: 0...1.0), blue:  .random(in: 0...1.0), alpha: 0.2)
    }
  }

  init(configuration: ContentConfiguration) {
    self._configuration = configuration
    super.init(frame: .null)

    let textLabel: UILabel = .init(frame: bounds)
    textLabel.font = .preferredFont(forTextStyle: .largeTitle)
//    textLabel.numberOfLines = .zero
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(textLabel)
    
    NSLayoutConstraint.activate([
      textLabel.topAnchor.constraint(equalTo: topAnchor),
      textLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      textLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      textLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    self.textLabel = textLabel
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension ContentView: UIContentView {
  var configuration: UIContentConfiguration {
    get {
      _configuration
    }
    set {
      _configuration = newValue as! ContentConfiguration
    }
  }

  @available(iOS 16.0, *) func supports(_ configuration: UIContentConfiguration) -> Bool {
    configuration is ContentConfiguration
  }
}
