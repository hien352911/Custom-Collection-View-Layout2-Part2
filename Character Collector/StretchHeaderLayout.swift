//
//  StretchHeaderLayout.swift
//  Character Collector
//
//  Created by buiduyhien on 6/28/20.
//  Copyright © 2020 Razeware, LLC. All rights reserved.
//

import UIKit

class StretchyHeaderAttributes: UICollectionViewLayoutAttributes {
    var deltaY: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! StretchyHeaderAttributes
        copy.deltaY = deltaY
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? StretchyHeaderAttributes {
            if attributes.deltaY == deltaY {
                return super.isEqual(object)
            }
        }
        return false
    }
}

class StretchHeaderLayout: UICollectionViewFlowLayout {
    override class var layoutAttributesClass: AnyClass {
        return StretchyHeaderAttributes.self
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect) as! [StretchyHeaderAttributes]
        
        let insets = collectionView!.contentInset
        let offset = collectionView!.contentOffset
        let minY = -insets.top
        if offset.y < minY {
            let deltaY = abs(offset.y - minY)
            for attributes in layoutAttributes {
                /*
                 representedElementKind: String? { get } // nil when representedElementCategory is UICollectionElementCategoryCell
                 */
                if let elementKind = attributes.representedElementKind {
                    if elementKind == UICollectionView.elementKindSectionHeader {
                        var frame = attributes.frame
                        frame.size.height = max(minY, headerReferenceSize.height + deltaY)
                        frame.origin.y = frame.minY - deltaY
                        attributes.deltaY = deltaY
                        attributes.frame = frame
                    }
                }
            }
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
