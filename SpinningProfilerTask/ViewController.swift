//
//  ViewController.swift
//  SpinningProfilerTask
//
//  Created by Sierra 4 on 02/03/17.
//  Copyright © 2017 code-brew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var mutlipler: Int?
    var index:Int?
    public static var heightCollectionView: Float?
    static var widthCollectionView: Float?
    let imageArray:[UIImage] = [#imageLiteral(resourceName: "profilePic0"),
                                #imageLiteral(resourceName: "profilePic1"),
                                #imageLiteral(resourceName: "profilePic2"),
                                #imageLiteral(resourceName: "profilePic3"),
                                #imageLiteral(resourceName: "profilePic4"),
                                #imageLiteral(resourceName: "profilePic5"),
                                #imageLiteral(resourceName: "profilePic6")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print(imageArray.count)
        return imageArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellForSectionNames = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MainCollectionViewCell
        
        let imageName = imageArray[Int(indexPath.item) % 7]
        cellForSectionNames.btnProfilePic.setImage(imageName, for: .normal)
        print(indexPath.item)
        if index == indexPath.item {
            cellForSectionNames.layer.borderWidth = 10
            cellForSectionNames.layer.borderColor = UIColor.purple.cgColor

        }
        else {
            cellForSectionNames.layer.borderWidth = 3
            cellForSectionNames.layer.borderColor = UIColor.white.cgColor
        }
        return cellForSectionNames
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
//        let cell = collectionView.cellForItem(at: indexPath)
        index = Int(indexPath.item)
        collectionView.reloadData()
    }
    
}
