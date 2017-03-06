//
//  circularArc.swift
//  SpinningProfilerTask
//
//  Created by Sierra 4 on 06/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import Foundation
import UIKit

//class CircularArc: UIView {
//    class func makeCircle() {
//        let circleCenter = CGPoint(x: 100, y: 100)
//        let circleRadius = CGFloat(80)
//        var decimalInput = 0.75
//        let start = CGFloat(3 * M_PI_2)
//        let end = start + CGFloat(2 * M_PI * decimalInput)
//        let circlePath = UIBezierPath(arcCenter: circleCenter, radius: circleRadius, startAngle: start, endAngle: end, clockwise: true)
//        circlePath.stroke()
//    }
//    
//
//}
let NoOfGlasses = 8
let π:CGFloat = CGFloat(M_PI)

@IBDesignable class CounterView: UIView {
    
    @IBInspectable var counter: Int = 5
    @IBInspectable var outlineColor: UIColor = UIColor.blue
    @IBInspectable var counterColor: UIColor = UIColor.lightGray
    
    override func draw(_ rect: CGRect) {
        // 1
        let center = CGPoint(x:bounds.width-65, y: bounds.height+15)
        
        // 2
        let radius: CGFloat = 870
        
        // 3
        let arcWidth: CGFloat = 105
        
        // 4
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * π
        
        // 5
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - arcWidth/2,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        
        // 6
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
    }
}
