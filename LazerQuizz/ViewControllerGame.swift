import UIKit

import UIKit

private let DeviceList = [
    /* iPod 5 */          "iPod5,1": "iPod Touch 5",
    /* iPhone 4 */        "iPhone3,1":  "iPhone 4", "iPhone3,2": "iPhone 4", "iPhone3,3": "iPhone 4",
    /* iPhone 4S */       "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */        "iPhone5,1": "iPhone 5", "iPhone5,2": "iPhone 5",
    /* iPhone 5C */       "iPhone5,3": "iPhone 5C", "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */       "iPhone6,1": "iPhone 5S", "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */        "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */   "iPhone7,1": "iPhone 6 Plus",
    /* iPad 2 */          "iPad2,1": "iPad 2", "iPad2,2": "iPad 2", "iPad2,3": "iPad 2", "iPad2,4": "iPad 2",
    /* iPad 3 */          "iPad3,1": "iPad 3", "iPad3,2": "iPad 3", "iPad3,3": "iPad 3",
    /* iPad 4 */          "iPad3,4": "iPad 4", "iPad3,5": "iPad 4", "iPad3,6": "iPad 4",
    /* iPad Air */        "iPad4,1": "iPad Air", "iPad4,2": "iPad Air", "iPad4,3": "iPad Air",
    /* iPad Air 2 */      "iPad5,1": "iPad Air 2", "iPad5,3": "iPad Air 2", "iPad5,4": "iPad Air 2",
    /* iPad Mini */       "iPad2,5": "iPad Mini", "iPad2,6": "iPad Mini", "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */     "iPad4,4": "iPad Mini", "iPad4,5": "iPad Mini", "iPad4,6": "iPad Mini",
    /* iPad Mini 3 */     "iPad4,7": "iPad Mini", "iPad4,8": "iPad Mini", "iPad4,9": "iPad Mini",
    /* Simulator */       "x86_64": "Simulator", "i386": "Simulator"
]

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        let mirror = reflect(machine)                // Swift 1.2
        // let mirror = Mirror(reflecting: machine)  // Swift 2.0
        var identifier = ""
        
        // Swift 1.2 - if you use Swift 2.0 comment this loop out.
        for i in 0..<mirror.count {
            if let value = mirror[i].1.value as? Int8 where value != 0 {
                identifier.append(UnicodeScalar(UInt8(value)))
            }
        }
        
        // Swift 2.0 and later - if you use Swift 2.0 uncomment his loop
        // for child in mirror.children where child.value as? Int8 != 0 {
        //     identifier.append(UnicodeScalar(UInt8(child.value as! Int8)))
        // }
        
        return DeviceList[identifier] ?? identifier
    }
    
}


class ViewControllerGame: UIViewController {
    
    var labelWidth : CGFloat?
    var labelHeight : CGFloat?
    var labelTopPositions : [Int] = []
    var labels : [DraggableLabel] = []
    var nextLabel : Int = 0 // index for "labelTopPositions" array
    var laser : UIView?
    var maxViews = 0
    var timer : NSTimer?
//    var leftBar : UIView?
//    var rightBar : UIView?
    var dictionaryOfAnswers = Dictionary<String,Int>()
    var arrayOfData = [Level]()
    var level = Int()
    var difficulty = String()
    var score : Int = 0
    var scoreReport : UILabel?
    var buttonBar : UIView?
    var backButton : UIButton?
    var otherButton : UIButton?
    
    var removableViews : [UIView] = [UIView]()
    var swipeGesture : UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    var swiped : Bool = false
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var label_left_option: UILabel!
    @IBOutlet weak var label_right_option: UILabel!
    
    let laserPeriod : Double = 0.0000018
    var pointsPerLaserMovement : CGFloat = 0.75
    let secondsToBegin : Float = 2.15
    
    let wrongAnswerColor : UIColor = UIColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 0.95)
    let correctAnswerColor : UIColor = UIColor(red: 0.15, green: 0.9, blue: 0.15, alpha: 0.95)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        self.levelSetup()
        
    
    }
    
    func levelSetup() {
        
        self.score = 0
        self.nextLabel = 0
        self.swiped = false
        self.labels.removeAll(keepCapacity: false)
        self.labelTopPositions.removeAll(keepCapacity: false)
        self.dictionaryOfAnswers.removeAll(keepCapacity: true)
        
        self.pointsPerLaserMovement = 0.75
                
        self.scoreReport = UILabel(frame: CGRectMake(10, -125, self.view.bounds.width - 20, 125))
        self.scoreReport!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.9)
        self.scoreReport!.layer.masksToBounds = true
        self.scoreReport!.layer.cornerRadius = 3
        self.removableViews.append(self.scoreReport!)
        self.view.addSubview(self.scoreReport!)
        
        self.buttonBar = UIView(frame: CGRectMake(10, self.view.bounds.height + 65, self.view.bounds.width - 20, 55))
        self.buttonBar!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.9)
        self.buttonBar!.layer.masksToBounds = true
        self.buttonBar!.layer.cornerRadius = 3
        self.removableViews.append(self.buttonBar!)
        self.view.addSubview(self.buttonBar!)
        
        self.backButton = UIButton(frame:CGRectMake(10, 0, 200, 30))
        self.backButton!.setTitle(NSLocalizedString("VOLTAR", comment:"Voltar ao menu"), forState: UIControlState.Normal)
        self.backButton?.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        self.backButton!.sizeToFit()
        self.backButton!.center.y = self.buttonBar!.bounds.height / 2
        self.backButton!.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.removableViews.append(self.backButton!)
        self.buttonBar!.addSubview(self.backButton!)
        
        self.swipeGesture = UISwipeGestureRecognizer(target:self, action:"detectSwipe:")
        self.swipeGesture.direction = .Down
        self.backgroundImage.addGestureRecognizer(self.swipeGesture)

        
        generateQuestion()
    }
    
    func detectSwipe(sender: UISwipeGestureRecognizer) {
        
        if (sender.direction == UISwipeGestureRecognizerDirection.Down && swiped == false) {
            swiped = true
            for i in self.nextLabel..<self.maxViews {
                if (self.labels[i].currentPosition == DraggableLabel.Position.Middle) {
                    swiped = false
                }
            }
            if (swiped == true) {
                self.backgroundImage.removeGestureRecognizer(self.swipeGesture)
                pointsPerLaserMovement *= 6
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        generateLaser()
    }
    
    func checkCollision () -> Bool {
        
        if (nextLabel >= self.maxViews) {
            return false
        }
        
        
        if (Int(laser!.center.y) > self.labelTopPositions[nextLabel]) {
            if (self.labels[self.nextLabel].currentPosition == DraggableLabel.Position.Left) {
                if (self.dictionaryOfAnswers.values.array[self.nextLabel] == 0){
                    self.correctAnswer(self.labels[nextLabel])
                } else {
                    self.wrongAnswer(self.labels[nextLabel])
                }
            } else if (self.labels[self.nextLabel].currentPosition == DraggableLabel.Position.Middle) {
                self.wrongAnswer(self.labels[nextLabel])
            } else if (self.labels[self.nextLabel].currentPosition == DraggableLabel.Position.Right) {
                if (self.dictionaryOfAnswers.values.array[self.nextLabel] == 0){
                    self.wrongAnswer(self.labels[nextLabel])
                } else {
                    self.correctAnswer(self.labels[nextLabel])
                }
            }
            
            self.labels[self.nextLabel].userInteractionEnabled = false
            self.labels[nextLabel].removeGestureRecognizer(labels[nextLabel].panRecognizer!)
            //            print(String(format: "Colidiu em %d com label %d da posicao %d com resposta %d\n", Int(laser!.center.y), nextLabel + 1, labelTopPositions[nextLabel], dictionaryOfAnswers.values.array[nextLabel]))
            
            nextLabel++
            return true
        }
        
        return false
    }
    
    func correctAnswer(label: DraggableLabel) {
        
        self.labels[self.nextLabel].backgroundColor = self.correctAnswerColor
        self.labels[self.nextLabel].playCorrectAnswer()
        ++score
    }
    
    func wrongAnswer(label: DraggableLabel) {
        
        self.labels[self.nextLabel].backgroundColor = self.wrongAnswerColor
        self.labels[self.nextLabel].playWrongAnswer()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        UIView.animateWithDuration(1.0, animations: { () -> Void in
            self.label_left_option.transform = CGAffineTransformMakeScale(1.4, 1.4)
            self.label_right_option.transform = CGAffineTransformMakeScale(1.4, 1.4)
            
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.label_left_option.transform = CGAffineTransformIdentity
                    self.label_right_option.transform = CGAffineTransformIdentity
                })
        })
        
        self.initializeTimer()
    }
    
    func initializeTimer() {
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("checkCollision"), userInfo: nil, repeats: true)
        // wait for the user to read the question
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(self.secondsToBegin * Float(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.animateLaser()
        }
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonAction() {
        
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func generateLaser() {
        
        self.laser = UIView(frame: CGRectMake(0, 57, self.view.bounds.width, 11))
        self.laser!.backgroundColor = UIColor.clearColor()
        
        var stream = UIView(frame: CGRectMake(0, 0, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.90, green: 0.15, blue: 0.15, alpha: 0.7)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 1, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.15, blue: 0.15, alpha: 0.75)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 2, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.15, blue: 0.15, alpha: 0.80)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 3, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.6, blue: 0.6, alpha: 0.90)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 4, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.75, blue: 0.75, alpha: 0.90)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 5, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 0.90)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 6, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.75, blue: 0.75, alpha: 0.90)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 7, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.6, blue: 0.6, alpha: 0.90)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 8, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.15, blue: 0.15, alpha: 0.80)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 9, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.95, green: 0.15, blue: 0.15, alpha: 0.75)
        self.laser!.addSubview(stream)
        
        stream = UIView(frame: CGRectMake(0, 10, self.view.bounds.width, 1))
        stream.backgroundColor = UIColor(red: 0.90, green: 0.15, blue: 0.15, alpha: 0.7)
        self.laser!.addSubview(stream)
        
        self.removableViews.append(self.laser!)
        self.view.addSubview(self.laser!)
        self.laser?.superview?.bringSubviewToFront(self.laser!)
        
    }
    
    func generateQuestion () {
        
        self.labelWidth = self.view.bounds.width / 3
        self.labelHeight = 40
        
//        self.leftBar = UIView(frame: CGRectMake(self.labelWidth!, -1, 3, self.view.bounds.height))
//        self.leftBar?.backgroundColor = UIColor.clearColor()
        self.removableViews.append(self.leftBar!)
        //self.view.addSubview(self.leftBar!)
        
//        self.rightBar = UIView(frame: CGRectMake(self.view.bounds.width - self.labelWidth!, -1, 3, self.view.bounds.height))
//        self.rightBar?.backgroundColor = UIColor.clearColor()
        self.removableViews.append(self.rightBar!)
        //self.view.addSubview(self.rightBar!)
        
        let pointX : CGFloat = view.bounds.width / 2 + self.leftBar!.bounds.width / 2 - (labelWidth! / 2)
        var pointY : CGFloat = 120
        
        let modelName = UIDevice.currentDevice().modelName
        println(modelName)
        
        if (modelName == "iPhone 4S") {
            pointY = 90
            self.labelHeight = 33
        } else if (modelName == "iPhone 5S" || modelName == "iPhone 5C" || modelName == "iPhone 5") {
            pointY = 100
        }
        
        println(arrayOfData[level].level_type)
        
        var question = AccessJSON.accessTheQuestion(arrayOfData[level].level_type)
        
        var arrayOfOptions = AccessJSON.accessTheOptions(arrayOfData[level].level_type, question: question, level: self.difficulty)
        println(arrayOfOptions)
        
        self.label_left_option.text = arrayOfOptions[0]
        
        self.label_right_option.text = arrayOfOptions[1]
        
        self.dictionaryOfAnswers = AccessJSON.accessTheAnswers(arrayOfData[level].level_type, question: question, level:self.difficulty, option1: String(stringInterpolationSegment : arrayOfOptions[0]), option2: String(stringInterpolationSegment: arrayOfOptions[1]))
        self.maxViews = dictionaryOfAnswers.count
        
        // Add the Views
        for i in 0..<self.maxViews {
            var newView = DraggableLabel(frame: CGRectMake(pointX, pointY, labelWidth!, labelHeight!))
            newView.text = dictionaryOfAnswers.keys.array[i]
            newView.textAlignment = NSTextAlignment.Center
            newView.layer.masksToBounds = true
            newView.layer.cornerRadius = 4
            newView.gameView = self
            newView.backgroundColor = UIColor.whiteColor()
            
            self.removableViews.append(newView)
            self.view.addSubview(newView)
            
            self.labels.append(newView)
            self.labelTopPositions.append(Int(pointY))
            
            
            
            if (modelName == "iPhone 4S") {
                pointY += 38
            } else if (modelName == "iPhone 5S" || modelName == "iPhone 5C" || modelName == "iPhone 5") {
                pointY += 47
            } else {
                pointY += 50
            }
        }
        
    }
    
    func reloadViewController() {
        
        self.backgroundImage.removeGestureRecognizer(self.swipeGesture)
        for view in self.removableViews {
            view.removeFromSuperview()
        }
        self.removableViews.removeAll(keepCapacity: false)
        self.levelSetup()
        self.generateLaser()
        self.initializeTimer()
    }
    
    func animateLaser() {
        
        UIView.animateWithDuration(self.laserPeriod, delay: 0, options: .CurveLinear, animations: { () -> Void in
            self.laser!.center.y += self.pointsPerLaserMovement
            }) { (result) -> Void in
                if (self.laser!.center.y <= self.view.bounds.height) {
                    self.animateLaser()
                    self.view.layoutIfNeeded()
                } else {
                    self.timer!.invalidate()
                    
                    if (self.score == self.maxViews && self.arrayOfData[self.level].level_score < 3) {
                        LevelServices.updateScore(self.arrayOfData[self.level])
                    }
                    
                    self.otherButton = UIButton(frame:CGRectMake(self.buttonBar!.bounds.width - 10, 0, 200, 30))
                    if (self.level >= 3) {
                        self.otherButton!.setTitle(NSLocalizedString("REPETIR", comment:"Repetir nível"), forState: UIControlState.Normal)
                        self.otherButton!.addTarget(self, action: "reloadViewController", forControlEvents: UIControlEvents.TouchUpInside)
                    } else if (self.score == self.maxViews && self.arrayOfData[self.level].level_score < 3) {self.otherButton!.setTitle(NSLocalizedString("PROXIMO", comment:"Próximo nível"), forState: UIControlState.Normal)
                        //LevelServices.updateScore(self.arrayOfData[self.level])
                        self.otherButton!.addTarget(self, action: "reloadViewController", forControlEvents: UIControlEvents.TouchUpInside)
                    } else if (self.arrayOfData[self.level].level_score < 3){
                        self.otherButton!.setTitle(NSLocalizedString("TENTAR", comment:"Tentar novamente"), forState: UIControlState.Normal)
                        self.otherButton!.addTarget(self, action: "reloadViewController", forControlEvents: UIControlEvents.TouchUpInside)
                    }
                    
                    self.otherButton!.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
                    
                    self.otherButton!.sizeToFit()
                    self.otherButton!.frame.origin.x -= self.otherButton!.bounds.width
                    self.otherButton!.center.y = self.buttonBar!.bounds.height / 2
                    self.removableViews.append(self.otherButton!)
                    self.buttonBar!.addSubview(self.otherButton!)
                    
                    self.view.bringSubviewToFront(self.scoreReport!)
                    self.view.bringSubviewToFront(self.buttonBar!)
                    
                    self.scoreReport!.text = String(format:NSLocalizedString("ACERTOU", comment:"Você acertou")+"\n%d "+NSLocalizedString("DE", comment:"de")+" %d", self.score, self.maxViews)
                    self.scoreReport!.textAlignment = .Center
                    self.scoreReport!.textColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
                    self.scoreReport!.font = UIFont.systemFontOfSize(45)
                    self.scoreReport!.numberOfLines = 0
                    self.scoreReport!.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    
                    UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 7.1, initialSpringVelocity: 7, options: nil, animations: { () -> Void in
                        self.scoreReport!.frame.origin.y = self.view.center.y - self.scoreReport!.bounds.height + 10
                        self.buttonBar!.frame.origin.y = self.view.center.y  + self.buttonBar!.bounds.height - 10
                        self.laser!.alpha = 0
                        self.view.layoutIfNeeded()
                        }, completion: { (result) -> Void in
                            
                    })
                    
                    return
                }
        }
    }
    
    func addEffect(){
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        
        var effectView = UIVisualEffectView(effect: effect)
        



        
        self.view.addSubview(effectView)
    }
    
    
}
