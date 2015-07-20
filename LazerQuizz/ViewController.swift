//
//  ViewController.swift
//  LazerQuizz
//
//  Created by Lucas Gabriel Silvério de Freitas on 06/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collection: UICollectionView!
    var arrayOfData = [Level]()
    var level = Int()
    var difficulty = String()
    var stars = Int()
    let starRemaining = [0, 0, 3, 6, 9, 12, 15, 18, 21, 24]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //var arrayOfOptions = AccessJSON.accessTheOptions("Qual a marca do carro?", level: "Facil")
        
        //AccessJSON.accessTheAnswers("Qual a marca do carro?", level: "Facil", option1: String(stringInterpolationSegment : arrayOfOptions[0]), option2: String(stringInterpolationSegment: arrayOfOptions[1]))
        
        let language = NSBundle.mainBundle().preferredLocalizations.first as! NSString
        
        println(language)
        
        if(!NSUserDefaults.standardUserDefaults().boolForKey("firstlaunch1.0")){
            //Put any code here and it will be executed only once.
            
            //            if(language.isEqualToString("pt")) {
            LevelServices.createLevel(0, score: 0, type: "Carros", block: false)
            LevelServices.createLevel(1, score: 0, type: "Biologia", block: false)
            LevelServices.createLevel(2, score: 0, type: "Geografia", block: true)
            LevelServices.createLevel(3, score: 0, type: "Historia", block: true)
            LevelServices.createLevel(4, score: 0, type: "Artes", block: true)
            LevelServices.createLevel(5, score: 0, type: "Esporte", block: true)
            LevelServices.createLevel(6, score: 0, type: "Series", block: true)
            LevelServices.createLevel(7, score: 0, type: "Quimica", block: true)
            //
            //            } else {
            //                //In English
            //                LevelServices.createLevel(0, score: 0, type: "Cars", block: false)
            //                LevelServices.createLevel(1, score: 0, type: "Biology", block: false)
            //                LevelServices.createLevel(2, score: 0, type: "Art", block: true)
            //                LevelServices.createLevel(3, score: 0, type: "Geography", block: true)
            //                LevelServices.createLevel(4, score: 0, type: "History", block: true)
            //                LevelServices.createLevel(5, score: 0, type: "Sport", block: true)
            //                LevelServices.createLevel(6, score: 0, type: "Series", block: true)
            //                LevelServices.createLevel(7, score: 0, type: "Chemistry", block: true)
            //
            //
            //
            //            }
            
            println("Is a first launch")
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstlaunch1.0")
            NSUserDefaults.standardUserDefaults().synchronize();
        }
        
        arrayOfData = LevelDAO.returnAllValues()
        //println(arrayOfData[2].level_block) FIXME: Array index out of range
        
        
        //println(arrayOfData[0].level_block)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.countStars()
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
            unlockedCell.lblCell.text = self.arrayOfData[indexPath.row].level_type
            
            switch(indexPath.row)
            {
            case 0:
                unlockedCell.imgType.image = UIImage(named: "carro.png")
                break
            case 1:
                unlockedCell.imgType.image = UIImage(named: "dna.png")
                break
            case 2:
                unlockedCell.imgType.image = UIImage(named: "two_globes.png")
                break
            default:
                unlockedCell.imgType.image = UIImage(named: "carro.png")
                break
            }
            
            unlockedCell.star1.image = UIImage(named: "star_empty.png")
            unlockedCell.star2.image = UIImage(named: "star_empty.png")
            unlockedCell.star3.image = UIImage(named: "star_empty.png")
            switch(arrayOfData[indexPath.row].level_score)
            {
            case 3:
                unlockedCell.star3.image = UIImage(named: "star.png")
                fallthrough
            case 2:
                unlockedCell.star2.image = UIImage(named: "star.png")
                fallthrough
            case 1:
                unlockedCell.star1.image = UIImage(named: "star.png")
                fallthrough
            default:
                break
            }
            
            return unlockedCell
        } else {
            

            let lockedCell: LockedCVCell = collectionView.dequeueReusableCellWithReuseIdentifier("locked", forIndexPath: indexPath) as! LockedCVCell
             lockedCell.lblCell.text = NSLocalizedString("BLOQUEADO", comment:"name of label blocked")

            if (starRemaining[indexPath.row] - self.stars == 1) {
                    lockedCell.lblRemaining.text = NSLocalizedString("FALTA", comment:"")
                    lockedCell.lblStar.text = String(starRemaining[indexPath.row] - self.stars) + " " + NSLocalizedString("ESTRELA", comment:"")
            } else {
                    lockedCell.lblRemaining.text = NSLocalizedString("FALTAM", comment:"")
                    lockedCell.lblStar.text = String(starRemaining[indexPath.row] - self.stars) + " " + NSLocalizedString("ESTRELAS", comment:"")
                }
            
            return lockedCell
            
        }
    
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //       print("Cell \(indexPath.row) selected")
        if(!arrayOfData[indexPath.row].level_block) {
            self.level = indexPath.row
            if(arrayOfData[indexPath.row].level_score == 0) {
                self.difficulty = "Facil";
            } else if(arrayOfData[indexPath.row].level_score == 1) {
                self.difficulty = "Medio"
            } else {
                self.difficulty = "Dificil"
            }
            
            performSegueWithIdentifier("toGame", sender: nil)
        }
    }
    
    
    //MARK: CollectionView Delegate FlowLayout
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAtIndexPath : NSIndexPath) -> CGSize {
        
        return CGSize(width: 127, height: 134)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationVC = segue.destinationViewController as! ViewControllerGame
        destinationVC.level = self.level
        destinationVC.difficulty = self.difficulty
        destinationVC.arrayOfData = self.arrayOfData
    }
    
    func countStars() {
        self.stars = 0
        for (var i = 0; i < arrayOfData.count; i++) {
            stars += Int(arrayOfData[i].level_score)
        }
    }
    
    //This method counts the scores of each level to unlock the locked levels.
    func unlockTheLevels() {
        println(self.stars)
        if (stars > 2 && arrayOfData[2].level_block == true) {
            LevelServices.updateBlock(arrayOfData[2])
        }
        if (self.stars > 5 && arrayOfData[3].level_block == true) {
            LevelServices.updateBlock(arrayOfData[3])
        }
        if (self.stars > 8 && arrayOfData[4].level_block == true ) {
            LevelServices.updateBlock(arrayOfData[4])
        }
        if (self.stars > 11 && arrayOfData[5].level_block == true) {
            LevelServices.updateBlock(arrayOfData[5])
        }
        if (self.stars > 14 && arrayOfData[6].level_block == true) {
            LevelServices.updateBlock(arrayOfData[6])
        }
        if (self.stars > 17 && arrayOfData[7].level_block == true) {
            LevelServices.updateBlock(arrayOfData[7])
        }
        if (self.stars > 20 && arrayOfData[8].level_block == true) {
            LevelServices.updateBlock(arrayOfData[8])
        }
        if (self.stars > 23 && arrayOfData[9].level_block == true) {
            LevelServices.updateBlock(arrayOfData[9])
        }
        
        arrayOfData = LevelDAO.returnAllValues()
        collection.reloadData()
    }
    
    
}

