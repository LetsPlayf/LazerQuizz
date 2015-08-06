//
//  TutorialViewController.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 05/08/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var top: NSLayoutConstraint!

    @IBOutlet weak var top2: NSLayoutConstraint!
    
    var tutorialView : UIView?
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         top.constant = CGFloat(1000)
        
         top2.constant = CGFloat(1000)
        // Do any additional setup after loading the view.
        
        
        
        
    }

    
    
    
    override func viewDidAppear(animated: Bool) {

        self.top.constant = CGFloat(0)
        self.top2.constant = CGFloat(0)
        
        UIView.animateWithDuration(1.0, animations: { () -> Void in
           
            self.view.layoutIfNeeded()
            
            }, completion: {
                (value: Bool) in
               
        })


        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
