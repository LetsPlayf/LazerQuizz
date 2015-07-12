import UIKit


class ViewControllerGame: UIViewController {
    
    var labelWidth : CGFloat?
    var labelHeight : CGFloat?
    var labelTopPositions : [Int] = []
    var labels : [DraggableLabel] = []
    var nextLabel : Int = 0 // index for "labelTopPositions" array
    var laser : UIView?
    let maxViews = 10
    var timer : NSTimer?
    var leftBar : UIView?
    var rightBar : UIView?
    var dictionaryOfAnswers = Dictionary<String,Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateQuestion()
        generateLaser()
        
    }
    
    
    func checkCollision () -> Bool {
        if (nextLabel >= self.maxViews) {
            return false
        }
        if (Int(laser!.center.y) > self.labelTopPositions[nextLabel]) {
            if self.labels[self.nextLabel].currentPosition == DraggableLabel.Position.Left{
                if (self.dictionaryOfAnswers.values.array[self.nextLabel] == 0){
                    self.labels[self.nextLabel].backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
                }else {
                    self.labels[self.nextLabel].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                }
            } else if self.labels[self.nextLabel].currentPosition == DraggableLabel.Position.Middle{
                if (self.dictionaryOfAnswers.values.array[self.nextLabel] == 0){
                    self.labels[self.nextLabel].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                }else {
                    self.labels[self.nextLabel].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                }
            } else if self.labels[self.nextLabel].currentPosition == DraggableLabel.Position.Right{
                if (self.dictionaryOfAnswers.values.array[self.nextLabel] == 0){
                    self.labels[self.nextLabel].backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
                }else {
                    self.labels[self.nextLabel].backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1)
                }
            }
            
            self.labels[self.nextLabel].userInteractionEnabled = false
            self.labels[nextLabel].removeGestureRecognizer(labels[nextLabel].panRecognizer!)
            nextLabel++
            print(String(format: "Colidiu em %d com label %d da posicao %d com resposta %d\n", Int(laser!.center.y), nextLabel, labelTopPositions[nextLabel - 1], dictionaryOfAnswers.values.array[nextLabel - 1]))
            return true
        }
        return false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("checkCollision"), userInfo: nil, repeats: true)
        // wait for the user to read the question
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.animateLaser()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func generateLaser () {
        
        var laser = UIView(frame: CGRectMake(0, 25, self.view.frame.width + self.view.bounds.width, 11))
        laser.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 0.8)
//        laser.center = CGPointMake(160, 20)
        
        self.view.addSubview(laser)
        //laser.backgroundColor = UIColor(patternImage: UIImage(named: "laser.png"))
        self.laser = laser
        self.laser?.superview?.bringSubviewToFront(self.laser!)

    }
    
    func generateQuestion () {
        
        self.labelWidth = self.view.bounds.width/3
        self.labelHeight = 35
        // Do any additional setup after loading the view, typically from a nib.
        
        self.leftBar = UIView(frame: CGRectMake(self.labelWidth!, -1, 3, self.view.bounds.height + self.view.frame.height))
        self.leftBar?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        self.view.addSubview(self.leftBar!)
        
        self.rightBar = UIView(frame: CGRectMake(self.view.bounds.width - self.labelWidth!, -1, 3, self.view.bounds.height + self.view.frame.height))
        self.rightBar?.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)
        self.view.addSubview(self.rightBar!)
        
        let pointX : CGFloat = view.bounds.width / 2 + self.leftBar!.bounds.width / 2 - (labelWidth! / 2)
        var pointY : CGFloat = 100
        
        var arrayOfOptions = AccessJSON.accessTheOptions("Qual a marca do carro?", level: "Facil")
        
        var optionLeft = UILabel(frame: CGRectMake(0, 35, 100, 20))
        optionLeft.text = arrayOfOptions[0]
        optionLeft.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.8)
        self.view.addSubview(optionLeft)
        
        var optionRight = UILabel(frame: CGRectMake(300, 35, 100, 20))
        optionRight.text = arrayOfOptions[1]
        optionRight.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.8)
        self.view.addSubview(optionRight)
        
        self.dictionaryOfAnswers = AccessJSON.accessTheAnswers("Qual a marca do carro?", level: "Facil", option1: String(stringInterpolationSegment : arrayOfOptions[0]), option2: String(stringInterpolationSegment: arrayOfOptions[1]))
        
        // Add the Views
        for i in 0..<self.maxViews {
            //            var pointX = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.width))))
            //            var pointY = CGFloat(UInt(arc4random() % UInt32(UInt(insetSize.height))))
            
            var newView = DraggableLabel(frame: CGRectMake(pointX, pointY, labelWidth!, labelHeight!))
            newView.text = dictionaryOfAnswers.keys.array[i]
            newView.textAlignment = NSTextAlignment.Center
            newView.gameView = self
            
            self.view.addSubview(newView)
            
            self.labels.append(newView)
            self.labelTopPositions.append(Int(pointY))
            
            pointY += 50
            
        }
        
    }
    
    func animateLaser() {
        UIView.animateWithDuration(0.000004, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.laser!.center.y += 0.5
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