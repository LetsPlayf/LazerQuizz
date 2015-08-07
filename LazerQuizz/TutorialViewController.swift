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
    var blurView : UIVisualEffectView?
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         top.constant = CGFloat(1000)
        
         top2.constant = CGFloat(1000)
        // Do any additional setup after loading the view.
        
        self.tutorialView = UILabel(frame: CGRectMake(10, -125, self.view.bounds.width - 20, 125))
        self.tutorialView!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.9)
        self.tutorialView!.layer.masksToBounds = true
        self.tutorialView!.layer.cornerRadius = 3



        var blur = UIBlurEffect(style: UIBlurEffectStyle.Light)

        
        blurView = UIVisualEffectView(effect: blur)
        
        
        blurView!.frame = self.view.bounds
        
        self.view.addSubview(blurView!)
        
        
        
        
    }

    
    @IBAction func tap(sender: AnyObject) {

          self.top.constant = CGFloat(0)
          self.top2.constant = CGFloat(0)
        
        UIView.animateKeyframesWithDuration(2.0, delay: 0.3, options: nil, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.50, animations: { () -> Void in
                
                self.tutorialView?.alpha = 0
                                self.view.layoutIfNeeded()
 
               
            })
            
            
            UIView.addKeyframeWithRelativeStartTime(1.0, relativeDuration: 0.25, animations: { () -> Void in
                
                self.blurView?.removeFromSuperview()

                
                
            })

            
            
            
            UIView.addKeyframeWithRelativeStartTime(1.5, relativeDuration: 0.25, animations: { () -> Void in
               
    
                

            })
            
            }) { (Bool) -> Void in
               

                
        }
        

    
    
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        self.view.addSubview(self.tutorialView!)
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.tutorialView!.frame.origin.y = self.view.center.y - self.tutorialView!.bounds.height + 10
        })
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
