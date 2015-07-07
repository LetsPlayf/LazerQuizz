//
//  ViewController.swift
//  IOS8SwiftDraggingViewsTutorial
//
//  Created by Arthur Knopper on 27/07/14.
//  Copyright (c) 2014 Arthur Knopper. All rights reserved.
//

import UIKit


class ViewControllerGame: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let halfSizeOfView = 25.0
        let maxViews = 10
        let labelWidth : CGFloat = 120
        let labelHeight : CGFloat = 35
        let pointX : CGFloat = view.frame.width / 2 - (labelWidth / 2)
        var pointY : CGFloat = 40
        let insetSize = CGRectInset(self.view.bounds, CGFloat(Int(2 * halfSizeOfView)), CGFloat(Int(2 * halfSizeOfView))).size
        
        // Add the Views
        for i in 0..<maxViews {
//            var pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
//            var pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
            
            var newView = DraggableLabel(frame: CGRectMake(pointX, pointY, labelWidth, labelHeight))
            self.view.addSubview(newView)
            
            pointY += 50
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

