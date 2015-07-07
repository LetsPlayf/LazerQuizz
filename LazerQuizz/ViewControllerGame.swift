import UIKit


class ViewControllerGame: UIViewController {
    
    var labelTopPositions : [Int] = []
    var labels : [DraggableLabel] = []
    var nextLabel : Int = 0 //index for "labelTopPositions" array
    var laser : UIView?
    let maxViews = 10
    var timer : NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let halfSizeOfView = 25.0
        let labelWidth : CGFloat = 120
        let labelHeight : CGFloat = 35
        let pointX : CGFloat = view.frame.width / 2 - (labelWidth / 2)
        var pointY : CGFloat = 100
        let insetSize = CGRectInset(self.view.bounds, CGFloat(Int(2 * halfSizeOfView)), CGFloat(Int(2 * halfSizeOfView))).size
        
        // Add the Views
        for i in 0..<self.maxViews {
            //            var pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
            //            var pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
            
            var newView = DraggableLabel(frame: CGRectMake(pointX, pointY, labelWidth, labelHeight))
            self.view.addSubview(newView)
            
            self.labels.append(newView)
            self.labelTopPositions.append(Int(pointY))
            
            pointY += 50
            
        }
        
    }
    
    func checkCollision () -> Bool {
        if (nextLabel >= self.maxViews) {
            return false
        }
        if (Int(laser!.center.y) > self.labelTopPositions[nextLabel]) {
            UIView.animateWithDuration(3, animations: { () -> Void in
                self.labels[self.nextLabel].backgroundColor = UIColor(red: 0.7, green: 0.4, blue: 0.2, alpha: 1)
            })
            self.labels[self.nextLabel].userInteractionEnabled = false
            nextLabel++
            print(String(format: "Colidiu em %d com label %d da posicao %d\n", Int(laser!.center.y), nextLabel, labelTopPositions[nextLabel - 1]))
            return true
        }
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        generateLaser()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("checkCollision"), userInfo: nil, repeats: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateLaser () {
        
        var laser = UILabel(frame: CGRectMake(0, 0, self.view.frame.width + self.view.bounds.width, 11))
        laser.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 0.8)
        laser.center = CGPointMake(160, 0)
        laser.textAlignment = NSTextAlignment.Center
        
        
        
        self.view.addSubview(laser)
        self.laser = laser
        self.laser?.superview?.bringSubviewToFront(self.laser!)

        
        animateLaser()
    }
    
    func animateLaser() {
        UIView.animateWithDuration(0.004, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.laser!.center.y += 1
            }) { (result) -> Void in
                if (self.laser!.center.y <= self.view.bounds.height) {
                    self.animateLaser()
                    self.view.layoutIfNeeded()
                }
                else {
                    return
                }
        }
    }
    
    
    
    
}

