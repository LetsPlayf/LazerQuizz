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
    var tutorialLabel : UILabel?
    var tutorialImage : UIImageView?
    var blurView : UIVisualEffectView?
    
    var time : Int = 0
    
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         top.constant = CGFloat(1000)
        
         top2.constant = CGFloat(1000)
        // Do any additional setup after loading the view.
        
        self.tutorialView = UIView(frame: CGRectMake(10, -125, self.view.bounds.width - 20, 200))
        self.tutorialView!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.9)
        self.tutorialView!.layer.masksToBounds = true
        self.tutorialView!.layer.cornerRadius = 3
        
        
        self.tutorialLabel = UILabel(frame: CGRectMake(0, 10, self.tutorialView!.bounds.width, self.tutorialView!.bounds.height * 0.40))
        
            
        self.tutorialLabel!.textAlignment = NSTextAlignment.Center
        self.tutorialLabel!.font = tutorialLabel?.font.fontWithSize(30)
        self.tutorialLabel?.text = "Bem vindo ao"

        self.tutorialView?.addSubview(self.tutorialLabel!)
        
        self.tutorialImage = UIImageView(frame: CGRectMake(0, self.tutorialLabel!.bounds.height + 20, self.tutorialView!.bounds.width, self.tutorialView!.bounds.height * 0.30))
        self.tutorialImage?.image = UIImage(named: "laserLabel.png")
        
        self.tutorialView?.addSubview(self.tutorialImage!)

        var blur = UIBlurEffect(style: UIBlurEffectStyle.Light)

        
        blurView = UIVisualEffectView(effect: blur)
        
        
        blurView!.frame = self.view.bounds
        
        self.view.addSubview(blurView!)
        
        self.time = 0
       
        
        

        
        
        
    }
    
    func animateBlur(){
        UIView.transitionWithView(self.blurView!, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.blurView!.hidden = true
            }, completion: nil)
    }

    
    @IBAction func tap(sender: AnyObject) {
        switch self.time {
            case 0:
                self.firstTap()
                self.time++
            default:
                self.time = 0
        }
    }
    
    
    func firstTap() {
        self.top.constant = CGFloat(0)
        self.top2.constant = CGFloat(0)
        
        
        UIView.animateKeyframesWithDuration(2.0, delay: 0.3, options: nil, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.3, animations: { () -> Void in
                
                self.tutorialView?.alpha = 0
            })
            UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 0.40, animations: { () -> Void in
                
                self.animateBlur()
            })
            UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.4, animations: { () -> Void in
                
                self.view.layoutIfNeeded()
            })
            
            }) { (result) -> Void in
                self.blurView?.removeFromSuperview()
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
