//
//  TutorialViewController.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 05/08/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit


class TutorialViewController: UIViewController, DraggableLabelDelegate {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
//    var leftBar : UIView?
//    var rightBar : UIView?

    
    
    @IBOutlet weak var top: NSLayoutConstraint!

    @IBOutlet weak var top2: NSLayoutConstraint!
    
    var tutorialView : UIView?
    var tutorialLabel : UILabel?
    var tutorialImage : UIImageView?
    var touchImage : UIImageView?
    
   // @IBOutlet weak var backgroundImage: UIImageView!
    
    var blurView : UIVisualEffectView?
    
    var time : Int = 0
    
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
     

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        top.constant = CGFloat(1000)
        
        top2.constant = CGFloat(1000)
        // Do any additional setup after loading the view.
        
        self.tutorialView = UIView(frame: CGRectMake(10, -125, self.view.bounds.width - 20, self.view.bounds.height * 0.5))
        self.tutorialView!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.9)
        self.tutorialView!.layer.masksToBounds = true
        self.tutorialView!.layer.cornerRadius = 3
        
        
        self.tutorialLabel = UILabel(frame: CGRectMake(0, 10, self.tutorialView!.bounds.width, self.tutorialView!.bounds.height * 0.40))
        
        
        self.tutorialLabel!.textAlignment = NSTextAlignment.Center
        self.tutorialLabel!.font = tutorialLabel?.font.fontWithSize(30)
        self.tutorialLabel?.text = "Bem vindo ao"
        
        self.tutorialView?.addSubview(self.tutorialLabel!)
        
        self.tutorialImage = UIImageView(frame: CGRectMake(15, self.tutorialLabel!.bounds.height + 10, self.tutorialView!.bounds.width - 30, self.tutorialView!.bounds.height * 0.30))
        self.tutorialImage?.image = UIImage(named: "laserLabel.png")
        
        self.tutorialView?.addSubview(self.tutorialImage!)
        
        var blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        
        blurView = UIVisualEffectView(effect: blur)
        
        
        blurView!.frame = self.view.bounds
        
        
        
        self.time = 0

        
        

        self.tutorialLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
        self.tutorialLabel?.numberOfLines = 0
        
       self.view.addSubview(blurView!)
        

    }
    
    //            switch (self.currentPosition) {
    //            case .Middle:
    //                if (self.frame.origin.x <= self.gameView?.leftBar!.frame.origin.x) {
    //                    self.moveLeft()
    //                } else if (self.frame.origin.x + self.frame.width >= self.gameView!.rightBar!.frame.origin.x + self.gameView!.rightBar!.frame.width) {
    //                    self.moveRight()
    //                }
    //                break
    //
    //            case .Left:
    //                if (self.frame.origin.x + self.frame.width >= self.gameView!.leftBar!.frame.origin.x + self.gameView!.leftBar!.frame.width) {
    //                    self.moveRight()
    //                } else {
    //                    self.fastSnapLeft()
    //                }
    //                break
    //
    //            case .Right:
    //                if (self.frame.origin.x <= self.gameView!.rightBar!.frame.origin.x) {
    //                    self.moveLeft()
    //                } else {
    //                    self.fastSnapRight()
    //                }
    //                break
    //
    //            default:
    //                print ("Error: Draggable Label has no set position.\n")
    //                exit(0)
    //                break

    
    func draggableLabel(label: DraggableLabel, didMoveToPosition position: DraggableLabel.Position) {
        switch (position) {
        case .Middle:
            if (label.frame.origin.x <= self.leftBar!.frame.origin.x) {
                label.moveLeft()
            } else if (label.frame.origin.x + label.frame.width >= self.rightBar!.frame.origin.x + self.rightBar!.frame.width) {
                label.moveRight()
            }
            break
            
        case .Left:
            if (label.frame.origin.x + label.frame.width >= self.leftBar!.frame.origin.x + self.leftBar!.frame.width) {
                label.moveRight()
            } else {
                label.fastSnapLeft()
            }
            break
            
        case .Right:
            if (label.frame.origin.x <= self.rightBar!.frame.origin.x) {
                label.moveLeft()
            } else {
                label.fastSnapRight()
            }
            break
            
        default:
            print ("Error: Draggable Label has no set position.\n")
            exit(0)
            break
        }
        
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
            
        case 1:
            
                self.secondTap()
                self.time++
            
            
        case 2:

            self.tutorialLabel?.text = "Então arraste a ? para o lado certo antes que o laser o atinja"
            

            self.thirdTap()
            self.time++
            
        case 3:

            self.fourthTap()
            self.time++
            
            
        default:
                self.time = 0
        }
    }
    
    
    func firstTap() {
        
        UIView.animateWithDuration(1.0, animations: {
            self.tutorialView?.alpha = 0
            }, completion: { (finished) -> Void in

                self.tutorialLabel?.text = "Sempre haverá duas opções"

                self.tutorialImage?.removeFromSuperview()
                UIView.animateWithDuration(1.0, animations: { () -> Void in
                    self.tutorialView?.alpha = 1
                })
        })
/*
        UIView.animateKeyframesWithDuration(2.0, delay: 0.3, options: nil, animations: { () -> Void in
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
            
                            self.tutorialView?.alpha = 0
                            self.tutorialLabel?.alpha = 0

                        })
            
            
            
            
                         UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.5, animations: { () -> Void in
            
                          

                            self.tutorialView?.alpha = 1
                            
                            
                        })
            
            
            
            
                        }) { (result) -> Void in
                            self.tutorialLabel?.text = "qualquer coisa"
                            self.tutorialLabel?.alpha = 1


                    }*/
            //self.tutorialLabel?.text = "qualquer coisa"
        
//        self.top.constant = CGFloat(0)
//        self.top2.constant = CGFloat(0)
//        
//        
//        UIView.animateKeyframesWithDuration(2.0, delay: 0.3, options: nil, animations: { () -> Void in
//            
//            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.3, animations: { () -> Void in
//                
//                self.tutorialView?.alpha = 0
//            })
//            UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 0.40, animations: { () -> Void in
//                
//                self.animateBlur()
//            })
//            UIView.addKeyframeWithRelativeStartTime(0.6, relativeDuration: 0.4, animations: { () -> Void in
//                
//                self.view.layoutIfNeeded()
//            })
//            
//            }) { (result) -> Void in
//                self.blurView?.removeFromSuperview()
//        }
    }
    
    
    func secondTap(){
        
                self.top.constant = CGFloat(0)
                self.top2.constant = CGFloat(0)
        
                tapGesture.enabled = false
        
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
                        self.tapGesture.enabled = true
                        self.blurView?.removeFromSuperview()
        }
        
        
        
    }
    
    
    func thirdTap(){
        
        UIView.animateWithDuration(1.0, animations: {
            self.tutorialView?.alpha = 1
            }, completion: { (finished) -> Void in
                
        
        })
    
        
        
        

        let labelWidth : CGFloat = self.view.bounds.width / 3
        let labelHeight : CGFloat = 40
        var pointX : CGFloat  = view.bounds.width / 2 + self.leftBar!.bounds.width / 2 - (labelWidth / 2)
        var pointY : CGFloat = 120
        
        

        
        var label = DraggableLabel(frame: CGRectMake(pointX, pointY, labelWidth, labelHeight))
            label.text = "Macaco"
            label.textAlignment = NSTextAlignment.Center
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 4
            //  label.gameView = self
            
            label.delegate = self
            label.backgroundColor = UIColor.whiteColor()
            
            
            self.view.addSubview(label)

        
        
    }
    
    
    func fourthTap(){
        
        UIView.animateWithDuration(1.0, animations: {
            self.tutorialView?.alpha = 0
            }, completion: { (finished) -> Void in
                
                
        })
    
    }
        
    
    
        

    override func viewDidAppear(animated: Bool) {
        
        self.view.addSubview(self.tutorialView!)
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.tutorialView!.frame.origin.y = self.view.center.y - self.tutorialView!.bounds.height/2 - 20
        })
        
        
        self.touchImage = UIImageView(frame: CGRectMake(self.view.bounds.width - 70, self.tutorialView!.bounds.height - 60, 50, 50))
        self.touchImage?.image = UIImage(named: "080.png")
        self.touchImage?.backgroundColor = UIColor.clearColor()
        self.tutorialView?.addSubview(self.touchImage!)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
