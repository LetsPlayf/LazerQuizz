//
//  CreditsViewController.swift
//  LazerQuizz
//
//  Created by Renan Geraldo on 31/07/15.
//  Copyright (c) 2015 LetsPlay. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {
    
    @IBOutlet weak var labelDeveloped: UILabel!
    var labelWidth : CGFloat?
    var labelHeight : CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.labelWidth = 140
        self.labelHeight = 40
        
        let pointX : CGFloat = view.bounds.width / 2 - (labelWidth! / 2)
        var pointY : CGFloat = view.bounds.height / 2 - 2 * self.labelHeight!
        
        
        
        for i in 0..<4 {
            var newView = CreditLabel(frame: CGRectMake(pointX, pointY, labelWidth!, labelHeight!))
            switch (i) {
            case 0:
                newView.text = "Lucas Freitas"
            case 1:
                newView.text = "Matheus Susin"
            case 2:
                newView.text = "Renan Geraldo"
            case 3:
                newView.text = "Thiago Coradi"
            default:
                newView.text = "ERROR"
            }
            newView.textAlignment = NSTextAlignment.Center
            newView.layer.masksToBounds = true
            newView.layer.cornerRadius = 4
            newView.backgroundColor = UIColor.whiteColor()
            
            self.view.addSubview(newView)
            
            pointY += 60
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goBack(sender:AnyObject){
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
