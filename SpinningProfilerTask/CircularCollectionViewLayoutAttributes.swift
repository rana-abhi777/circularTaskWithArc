//
//  CircularCollectionViewLayout.swift
//  CircularTask
//
//  Created by Sierra 4 on 02/03/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    // 1
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle: CGFloat = 0 {
        // 2
        didSet {
            zIndex = Int(90 * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    // 3
    
    override func copy(with zone: NSZone?) -> Any {
        let copiedAttributes: CircularCollectionViewLayoutAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}


class CircularCollectionViewLayout: UICollectionViewLayout {
    let itemSize = CGSize(width: 100, height: 100)
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
    }
    
    
    var radius: CGFloat = 375 {
        didSet {
            invalidateLayout() //required to again validate the layout of the collection view
        }
    }
    
    var anglePerItem: CGFloat {
        //return atan(itemSize.width / 80)
        return atan(0.36397023426)
    }
    
    var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    override var collectionViewContentSize : CGSize {
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0)) * itemSize.width,
                      height: collectionView!.bounds.height)
    }
    
    
    
    override class var layoutAttributesClass : AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    override func prepare() {
        super.prepare()
        
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        attributesList = (0..<collectionView!.numberOfItems(inSection: 0)).map { (i)
            -> CircularCollectionViewLayoutAttributes in
            
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: NSIndexPath(item: i , section: 0) as IndexPath)
            
            attributes.size = self.itemSize
            
            attributes.center = CGPoint(x: centerX, y: 130)
            
            
            attributes.angle = self.angle + self.anglePerItem * CGFloat(i)
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            return attributes
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return attributesList[indexPath.row]
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
//    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
//        let pointToOffset = CGPoint(x: itemSize.height * 3 + 0, y: itemSize.width * 3 + 0)
//        var point = CGPoint(x: 1, y: 2)
//        point = targetContentOffset(forProposedContentOffset: pointToOffset)
//        print("\(point.x) \(point.y)")
//        return point
//    }
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if let cv = self.collectionView {
            
            let cvBounds = cv.bounds
            let halfHeight = cvBounds.size.height * 0.5
            let proposedContentOffsetCenterY = proposedContentOffset.y + halfHeight
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    if (attributes.center.y == 0) || (attributes.center.y > (cv.contentOffset.y + halfHeight) && velocity.y < 0) {
                        continue
                    }
                    
                    // == First time in the loop == //
                    guard let candAttrs = candidateAttributes else {
                        candidateAttributes = attributes
                        continue
                    }
                    
                    let a = attributes.center.y - proposedContentOffsetCenterY
                    let b = candAttrs.center.y - proposedContentOffsetCenterY
                    
                    if fabsf(Float(a)) < fabsf(Float(b)) {
                        candidateAttributes = attributes;
                    }
                }
                
                if(proposedContentOffset.y == -(cv.contentInset.top)) {
                    return proposedContentOffset
                }
                
                return CGPoint(x: proposedContentOffset.x, y: floor(candidateAttributes!.center.y - halfHeight))
            }
        }
        
        // fallback
        return super.targetContentOffset(forProposedContentOffset: proposedContentOffset)
    }
    
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

