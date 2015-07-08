
import UIKit

class DraggableLabel: UILabel {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    var panRecognizer : UIPanGestureRecognizer?
    var currentPosition : Position = .Middle
    let snapTime : NSTimeInterval = 0.25
    
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
