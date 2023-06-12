//
//  DynamicCollectionViewCell.swift
//  DynamicFlowLayout
//
//  Created by Jinwoo Kim on 5/25/23.
//

import UIKit

@MainActor
final class DynamicCollectionViewCell: UICollectionViewCell {
  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    let size: CGSize = contentView.systemLayoutSizeFitting(layoutAttributes.size, withHorizontalFittingPriority: .fittingSizeLevel, verticalFittingPriority: .fittingSizeLevel)

    guard size != .zero else {
      return super.preferredLayoutAttributesFitting(layoutAttributes)
    }
    
    let finalLayoutAttributes: UICollectionViewLayoutAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
    finalLayoutAttributes.size = size

    return finalLayoutAttributes
  }
}
