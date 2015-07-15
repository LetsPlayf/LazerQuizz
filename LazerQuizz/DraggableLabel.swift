import UIKit

class DraggableLabel: UILabel {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var panRecognizer : UIPanGestureRecognizer?
    var currentPosition : Position = .Middle
    let snapTime : NSTimeInterval = 0.25
    let fastSnapTime: NSTimeInterval = 0.1
    var gameView : ViewControllerGame?
    
    enum Position {
        case Left
        case Middle
        case Right
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.userInteractionEnabled = true
        self.panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
        self.addGestureRecognizer(self.panRecognizer!)
        
        //randomize view color
        //        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
        //        let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
        //        let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let blueValue = CGFloat(Int(arc4random() % 55) + 140) / 255.0
        let greenValue = CGFloat(190) / 255.0
        let redValue = CGFloat(Int(arc4random() % 55) + 140) / 255.0
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.textAlignment = NSTextAlignment.Center
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playCorrectAnswer() {
        var label : UILabel = UILabel(frame: CGRectMake(self.frame.width / 2 - 20, self.frame.height / 2 - 20, 40, 40))
        label.text = "+1"
        label.font = UIFont.systemFontOfSize(28)
        label.textColor = UIColor.blueColor()
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        UIView.animateWithDuration(1, animations: { () -> Void in
            label.frame.origin.y -= 30
            label.alpha = 0
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
            }) { (result) -> Void in
                
        }
    }
    
    func playWrongAnswer() {
        var label : UILabel = UILabel(frame: CGRectMake(self.frame.width / 2 - 25, self.frame.height / 2 - 25, 50, 50))
        label.text = "X"
        label.font = UIFont.systemFontOfSize(50)
        label.textColor = UIColor.grayColor()
        label.textAlignment = NSTextAlignment.Center
        self.addSubview(label)
        //label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(M_PI_2))
        UIView.animateWithDuration(1, animations: { () -> Void in
            label.transform = CGAffineTransformRotate(CGAffineTransformIdentity, CGFloat(-1 * M_PI))
            label.alpha = 0.0
            self.layoutIfNeeded()
            self.superview?.layoutIfNeeded()
            }) { (result) -> Void in
        }
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        var translation  = recognizer.translationInView(self.superview!)
        self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y)
        
        
        if (recognizer.state == UIGestureRecognizerState.Ended) {
            switch (self.currentPosition) {
            case .Middle:
                if (self.frame.origin.x <= self.gameView?.leftBar!.frame.origin.x) {
                    self.moveLeft()
                } else if (self.frame.origin.x + self.frame.width >= self.gameView!.rightBar!.frame.origin.x + self.gameView!.rightBar!.frame.width) {
                    self.moveRight()
                }
                break
                
            case .Left:
                if (self.frame.origin.x + self.frame.width >= self.gameView!.leftBar!.frame.origin.x + self.gameView!.leftBar!.frame.width) {
                    self.moveRight()
                } else {
                    self.fastSnapLeft()
                }
                break
                
            case .Right:
                if (self.frame.origin.x <= self.gameView!.rightBar!.frame.origin.x) {
                    self.moveLeft()
                } else {
                    self.fastSnapRight()
                }
                break
                
            default:
                print ("Error: Draggable Label has no set position.\n")
                exit(0)
                break
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        // Promote the touched view
        //        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
    }
    
    func fastSnapLeft() {
        UIView.animateWithDuration(self.fastSnapTime, delay: 0.0, options: nil, animations: { () -> Void in
            self.frame.origin.x = 0
            self.superview?.layoutIfNeeded()
            }) { (result) -> Void in
                
        }
    }
    
    func fastSnapRight() {
        UIView.animateWithDuration(self.fastSnapTime, delay: 0.0, options: nil, animations: { () -> Void in
            self.frame.origin.x = self.superview!.bounds.width - self.bounds.width
            self.superview?.layoutIfNeeded()
            }) { (result) -> Void in
                
        }
    }
    
    
    func moveLeft() {
        UIView.animateWithDuration(self.snapTime, delay: 0.0, options: nil, animations: { () -> Void in
            self.frame.origin.x = 0
            self.superview?.layoutIfNeeded()
            self.currentPosition = .Left
            }) { (result) -> Void in
                
        }
    }
    
    func moveRight() {
        UIView.animateWithDuration(self.snapTime, delay: 0.0, options: nil, animations: { () -> Void in
            self.frame.origin.x = self.superview!.bounds.width - self.bounds.width
            self.superview?.layoutIfNeeded()
            self.currentPosition = .Right
            }) { (result) -> Void in
                
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
    // Drawing code
    }
    */
    
}
