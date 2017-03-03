//
//  commonClass.swift
//  SpinningProfilerTask
//
//  Created by Sierra 4 on 03/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import Foundation
class commonClass {
    static var heightCollectionView: Float?
    static var widhtCollectionView: Float?
    
    class func SetDimensions(height: Float, width: Float){
        commonClass.heightCollectionView = height
        commonClass.widhtCollectionView = width
    }
}
