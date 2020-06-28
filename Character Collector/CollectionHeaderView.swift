//
//  CollectionHeaderView.swift
//  Character Collector
//
//  Created by buiduyhien on 6/28/20.
//  Copyright © 2020 Razeware, LLC. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var foregroundImage: UIImageView!
    
    @IBOutlet weak var backgroundImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var foregroundImageHeightConstraint: NSLayoutConstraint!
    
    var backgroundImageHeight: CGFloat = 0
    var foregroundImageHeight: CGFloat = 0
    var previousHeight: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImageHeight = backgroundImage.bounds.height
        foregroundImageHeight = foregroundImage.bounds.height
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let attributes = layoutAttributes as! StretchyHeaderAttributes
        
        let height = attributes.frame.height
        if previousHeight != height {
            backgroundImageHeightConstraint.constant = backgroundImageHeight - attributes.deltaY
            foregroundImageHeightConstraint.constant = foregroundImageHeight + attributes.deltaY
            previousHeight = height
        }
    }
}
