//
//  UICollectionViewStretchFlowLayout.swift
//  Rx_Github
//
//  Created by Dong-Ho Choi on 2022/03/13.
//

import UIKit

class UICollectionViewStretchFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.sectionHeadersPinToVisibleBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = self.collectionView else { return nil }
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
    
        let offset = collectionView.contentOffset

        if let firstHeader = layoutAttributes.first(where: { attributes in
            return attributes.representedElementKind == UICollectionView.elementKindSectionHeader && offset.y < 0
        }) {
            let origin = CGPoint(x: firstHeader.frame.origin.x, y: firstHeader.frame.minY - offset.y.magnitude)
            let size = CGSize(width: firstHeader.frame.width, height: max(0, headerReferenceSize.height + offset.y.magnitude))
            firstHeader.frame = CGRect(origin: origin, size: size)
        }
        return layoutAttributes
    }
}
