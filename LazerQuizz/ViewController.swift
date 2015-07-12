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
   
    //var arrayOfOptions = AccessJSON.accessTheOptions("Qual a marca do carro?", level: "Facil")
        
    //AccessJSON.accessTheAnswers("Qual a marca do carro?", level: "Facil", option1: String(stringInterpolationSegment : arrayOfOptions[0]), option2: String(stringInterpolationSegment: arrayOfOptions[1]))
        
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("firstlaunch1.0")){
            //Put any code here and it will be executed only once.
            LevelServices.createLevel(0, score: 0, type: "Carro", block: false)
            
            
            
            println("Is a first launch")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstlaunch1.0")
            NSUserDefaults.standardUserDefaults().synchronize();
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection View Delegates and DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var results = LevelDAO.returnAllValues()
        return results.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var results = LevelDAO.returnAllValues()
        if(!results[indexPath.row].level_block){
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
//        print("Cell \(indexPath.row) selected")
        if(indexPath.row <= 5){
            performSegueWithIdentifier("toGame", sender: nil)
        }
    }
    
    
    //MARK: CollectionView Delegate FlowLayout
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAtIndexPath : NSIndexPath) -> CGSize {
        
        
        
        return CGSize(width: 130, height: 100)
    }
    
    
    
}

