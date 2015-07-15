//
//  ViewController.swift
//  LazerQuizz
//
//  Created by Lucas Gabriel Silvério de Freitas on 06/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    var arrayOfData = [Level]()
    var level = Int()
    var difficulty = String()
    
    override func viewDidLoad() {
        
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
   
    //var arrayOfOptions = AccessJSON.accessTheOptions("Qual a marca do carro?", level: "Facil")
        
    //AccessJSON.accessTheAnswers("Qual a marca do carro?", level: "Facil", option1: String(stringInterpolationSegment : arrayOfOptions[0]), option2: String(stringInterpolationSegment: arrayOfOptions[1]))
        
        let language = NSBundle.mainBundle().preferredLocalizations.first as! NSString
        
        println(language)
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("firstlaunch1.0")){
            //Put any code here and it will be executed only once.
            
            if(language.isEqualToString("pt")) {

                LevelServices.createLevel(0, score: 0, type: "Carro", block: false)
                LevelServices.createLevel(1, score: 0, type: "Biologia", block: false)
                LevelServices.createLevel(2, score: 0, type: "Artes", block: true)
                LevelServices.createLevel(3, score: 0, type: "Geografia", block: true)
            }
            println("Is a first launch")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstlaunch1.0")
            NSUserDefaults.standardUserDefaults().synchronize();
        }
        
        arrayOfData = LevelDAO.returnAllValues()
        //println(arrayOfData[2].level_block) FIXME: Array index out of range

        
        //println(arrayOfData[0].level_block)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        
        self.unlockTheLevels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Collection View Delegates and DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  arrayOfData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if(!arrayOfData[indexPath.row].level_block){
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
//       print("Cell \(indexPath.row) selected")
        if(!arrayOfData[indexPath.row].level_block){
            self.level = indexPath.row
            if(arrayOfData[indexPath.row].level_score == 0){
                self.difficulty = "Facil";
            }
            else if(arrayOfData[indexPath.row].level_score == 1){
                self.difficulty = "Medio"
            }
            else{
                self.difficulty = "Dificil"
            }
            
            performSegueWithIdentifier("toGame", sender: nil)
        }
    }
    
    
    //MARK: CollectionView Delegate FlowLayout
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAtIndexPath : NSIndexPath) -> CGSize {
        
        
        
        return CGSize(width: 130, height: 100)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! ViewControllerGame
        destinationVC.level = self.level
        destinationVC.difficulty = self.difficulty
        destinationVC.arrayOfData = self.arrayOfData
    }
    
    //This method counts the scores of each level to unlock the locked levels.
    func unlockTheLevels(){
        var stars = 0
        for(var i = 0 ; i < arrayOfData.count ; i++){
            stars += Int(arrayOfData[i].level_score)
        }
        println(stars)
        if(stars > 3 && arrayOfData[2].level_block == true){
            LevelServices.updateBlock(arrayOfData[2])
            
        }
        if(stars > 6 && arrayOfData[3].level_block == true){
            LevelServices.updateBlock(arrayOfData[3])
        }
        if(stars > 9 && arrayOfData[4].level_block == true){
            LevelServices.updateBlock(arrayOfData[4])
        }
        if(stars > 12 && arrayOfData[5].level_block == true){
            LevelServices.updateBlock(arrayOfData[5])
        }
        if(stars > 15 && arrayOfData[6].level_block == true){
            LevelServices.updateBlock(arrayOfData[5])
        }

        arrayOfData = LevelDAO.returnAllValues()
    
    }
    
    
}

