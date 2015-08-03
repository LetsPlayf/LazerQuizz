//
//  CreditLabel.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 31/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit

class CreditLabel: UILabel {
    
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var panRecognizer : UIPanGestureRecognizer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.userInteractionEnabled = true
        self.panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
        self.addGestureRecognizer(self.panRecognizer!)
        
        let blueValue = CGFloat(Int(arc4random() % 55) + 140) / 255.0
        let greenValue = CGFloat(190) / 255.0
        let redValue = CGFloat(Int(arc4random() % 55) + 140) / 255.0
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.textAlignment = NSTextAlignment.Center
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // Promote the touched view
        //        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
    

}
