//
//  NSCollectionLayoutGroup+Flow.swift
//  CenteredCompositionalLayout
//
//  Created by Jinwoo Kim on 6/9/23.
//

import UIKit

extension NSCollectionLayoutGroup {
  enum FlowAlignment: Sendable {
    case left, center, right
  }

  class func flow(layoutSize: NSCollectionLayoutSize, alignment: FlowAlignment, horizontalSpacing: CGFloat, verticalSpacing: CGFloat, section: Int, collectionView: UICollectionView?) -> Self {
    custom(layoutSize: layoutSize) { [weak collectionView] envrionment -> [NSCollectionLayoutGroupCustomItem] in
      guard let collectionView else {
        return .init()
      }

      let contentSize: CGSize = envrionment.container.effectiveContentSize
      let numberOfItems: Int = collectionView.numberOfItems(inSection: section)

      var remainingWidth: CGFloat = contentSize.width
      var y: CGFloat = envrionment.container.effectiveContentInsets.top
      var tmpY: CGFloat = y

      var results: [NSCollectionLayoutGroupCustomItem] = .init()
      var tmpItems: [NSCollectionLayoutGroupCustomItem] = .init()

      func cleanup() {
        guard !tmpItems.isEmpty else {
          return
        }

        switch alignment {
        case .left:
          var tmpX: CGFloat = envrionment.container.effectiveContentInsets.leading

          tmpItems.enumerated().forEach { index, tmpItem in
            let new: NSCollectionLayoutGroupCustomItem = .init(frame: .init(origin: .init(x: tmpX + (index == .zero ? .zero : horizontalSpacing), y: tmpItem.frame.origin.y), size: tmpItem.frame.size))
            tmpX += new.frame.size.width + (index == .zero ? .zero : horizontalSpacing)
            results.append(new)
          }

          tmpItems = .init()
        case .center:
          let totalWidth: CGFloat = tmpItems
            .reduce(-horizontalSpacing) { partialResult, item in
              return partialResult + item.frame.size.width + horizontalSpacing
            }

          let offset: CGFloat = (contentSize.width - totalWidth) * 0.5 + envrionment.container.effectiveContentInsets.leading
          var tmpX: CGFloat = offset

          tmpItems.enumerated().forEach { index, tmpItem in
            let new: NSCollectionLayoutGroupCustomItem = .init(frame: .init(origin: .init(x: tmpX + (index == .zero ? .zero : horizontalSpacing), y: tmpItem.frame.origin.y), size: tmpItem.frame.size))
            tmpX += new.frame.size.width + (index == .zero ? .zero : horizontalSpacing)
            results.append(new)
          }

          tmpItems = .init()
        case .right:
          let totalWidth: CGFloat = tmpItems
            .reduce(-horizontalSpacing) { partialResult, item in
              return partialResult + item.frame.size.width + horizontalSpacing
            }

          let offset: CGFloat = contentSize.width - totalWidth + envrionment.container.effectiveContentInsets.leading
          var tmpX: CGFloat = offset

          tmpItems.enumerated().forEach { index, tmpItem in
            let new: NSCollectionLayoutGroupCustomItem = .init(frame: .init(origin: .init(x: tmpX + (index == .zero ? .zero : horizontalSpacing), y: tmpItem.frame.origin.y), size: tmpItem.frame.size))
            tmpX += new.frame.size.width + (index == .zero ? .zero : horizontalSpacing)
            results.append(new)
          }

          tmpItems = .init()
        }
      }

      //

      for item in 0..<numberOfItems {
        let indexPath: IndexPath = .init(item: item, section: section)

        let initialLayoutAttributes: UICollectionViewLayoutAttributes = .init(forCellWith: indexPath)
        initialLayoutAttributes.size = contentSize

        let layoutAttributes: UICollectionViewLayoutAttributes = (collectionView.cellForItem(at: indexPath) ?? UICollectionViewCell()).preferredLayoutAttributesFitting(initialLayoutAttributes)

        let size: CGSize = layoutAttributes.size

        let frame: CGRect

        if remainingWidth < (size.width + (tmpItems.isEmpty ? .zero : horizontalSpacing)) {
          cleanup()

          if remainingWidth == contentSize.width {
            y += tmpY + verticalSpacing
            frame = .init(origin: .init(x: .zero, y: y), size: size)
            y += size.height + verticalSpacing
            tmpY = .zero
            remainingWidth = contentSize.width
          } else {
            y += tmpY + verticalSpacing
            frame = .init(origin: .init(x: .zero, y: y), size: size)
            tmpY = size.height
            remainingWidth = contentSize.width - size.width
          }
        } else {
          frame = .init(origin: .init(x: .zero, y: y), size: size)
          remainingWidth -= size.width + horizontalSpacing
          tmpY = max(tmpY, size.height)
        }

        tmpItems.append(.init(frame: frame))
      }

      cleanup()

      //

      return results
    }
  }
}
