//
//  MainCollectionViewCell.swift
//  SpinningProfilerTask
//
//  Created by Sierra 4 on 02/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var btnProfilePic: UIButton!
    
//    override func draw(_ rect: CGRect) { //Your code should go here.
////        super.draw(rect)
////        self.layer.cornerRadius = self.frame.size.width / 2
//    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = 50
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let circularlayoutAttributes = layoutAttributes as! CircularCollectionViewLayoutAttributes
        //line to transform image to rotated angle
        btnProfilePic.transform = CGAffineTransform(rotationAngle: -circularlayoutAttributes.angle)
        self.layer.anchorPoint = circularlayoutAttributes.anchorPoint
        self.center.y += (circularlayoutAttributes.anchorPoint.y - 0) * self.bounds.height
    }
}
