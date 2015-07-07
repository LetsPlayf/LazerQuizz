//
//  ViewController.swift
//  LazerQuizz
//
//  Created by Lucas Gabriel Silvério de Freitas on 06/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection View Delegates and DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(indexPath.row <= 5){
            let unlockedCell:  UnlockedCVCell = collectionView.dequeueReusableCellWithReuseIdentifier("unlocked", forIndexPath: indexPath) as! UnlockedCVCell
            unlockedCell.lblCell.text = "Label :"
            unlockedCell.imgCell.image = UIImage(named: "imagem")
            return unlockedCell
        }
        else{
            
            let lockedCell: LockedCVCell = collectionView.dequeueReusableCellWithReuseIdentifier("locked", forIndexPath: indexPath) as! LockedCVCell
            return lockedCell
        }
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Cell \(indexPath.row) selected")
        if(indexPath.row <= 5){
            performSegueWithIdentifier("toGame", sender: nil)
        }
    }
    
    
    //MARK: CollectionView Delegate FlowLayout
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAtIndexPath : NSIndexPath) -> CGSize {
        
        
        
        return CGSize(width: 125, height: 125)
    }
    
    
    
}

