
import UIKit

class DraggableLabel: UILabel {
    var lastLocation:CGPoint = CGPointMake(0, 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
        self.userInteractionEnabled = true
        var panRecognizer = UIPanGestureRecognizer(target:self, action:"detectPan:")
        self.gestureRecognizers = [panRecognizer]
      
        //randomize view color
//        let blueValue = CGFloat(Int(arc4random() % 255)) / 255.0
//        let greenValue = CGFloat(Int(arc4random() % 255)) / 255.0
//        let redValue = CGFloat(Int(arc4random() % 255)) / 255.0
        let blueValue = CGFloat(Int(arc4random() % 55) + 140) / 255.0
        let greenValue = CGFloat(240) / 255.0
        let redValue = CGFloat(Int(arc4random() % 55) + 140) / 255.0
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        self.text = "TestTestTest"
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
        self.superview?.bringSubviewToFront(self)
        
        // Remember original location
        lastLocation = self.center
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
