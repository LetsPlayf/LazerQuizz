import UIKit


class ViewControllerGame: UIViewController {
    
    var labelTopPositions : [Int] = []
    
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
            
            self.labelTopPositions.append(Int(pointY))
            
            pointY += 50
            
        }
        
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        generateLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateLabels(){
        
        var label = UILabel(frame: CGRectMake(0, 0, self.view.frame.width + self.view.bounds.width, 15))
        label.backgroundColor = UIColor.redColor()
        label.center = CGPointMake(160, 0)
        label.textAlignment = NSTextAlignment.Center
        
        
        
        self.view.addSubview(label)
        
        /*UIView.animateWithDuration(15, animations: { () -> Void in
        label.center.y = self.view.bounds.height
        
        })*/
        
        UIView.animateWithDuration(15, delay: 0, options: .CurveLinear, animations: { () -> Void in
            label.center.y = self.view.bounds.height
            }) { (result) -> Void in
                
        }
        
    }
    
    
}

