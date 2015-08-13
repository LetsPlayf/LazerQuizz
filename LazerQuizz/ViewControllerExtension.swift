//
//  ViewControllerExtension.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 13/08/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    
    var rightBar : UIView? {
        self.rightBar?.frame = CGRectMake(self.view.bounds.width - self.view.bounds.width / 3, -1, 3, self.view.bounds.height)
       self.rightBar?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.rightBar!)

        return self.rightBar
    }
    
    var leftBar : UIView? {
        self.leftBar?.frame = CGRectMake(self.view.bounds.width - self.view.bounds.width - self.view.bounds.width / 3, -1, 3, self.view.bounds.height)
        self.leftBar?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.leftBar!)

        return self.leftBar
    }
}