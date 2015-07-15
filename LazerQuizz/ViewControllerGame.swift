import UIKit


class ViewControllerGame: UIViewController {
    
    var labelWidth : CGFloat?
    var labelHeight : CGFloat?
    var labelTopPositions : [Int] = []
    var labels : [DraggableLabel] = []
    var nextLabel : Int = 0 // index for "labelTopPositions" array
    var laser : UIView?
    var maxViews = 0
    var timer : NSTimer?
    var leftBar : UIView?
    var rightBar : UIView?
    var dictionaryOfAnswers = Dictionary<String,Int>()
    var arrayOfData = [Level]()
    var level = Int()
    var difficulty = String()
    var score : Int = 0
    var scoreReport : UILabel?
    var buttonBar : UIView?
    var backButton : UIButton?

    let wrongAnswerColor : UIColor = UIColor(red: 0.9, green: 0.15, blue: 0.15, alpha: 0.95)
    let correctAnswerColor : UIColor = UIColor(red: 0.15, green: 0.9, blue: 0.15, alpha: 0.95)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.scoreReport = UILabel(frame: CGRectMake(10, -125, self.view.bounds.width - 20, 125))
        self.scoreReport!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.5)
        self.scoreReport!.layer.masksToBounds = true
        self.scoreReport!.layer.cornerRadius = 3
        self.view.addSubview(self.scoreReport!)
        
        self.buttonBar = UIView(frame: CGRectMake(10, self.view.bounds.height + 65, self.view.bounds.width - 20, 55))
        self.buttonBar!.backgroundColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.5)
        self.buttonBar!.layer.masksToBounds = true
        self.buttonBar!.layer.cornerRadius = 3
        self.view.addSubview(self.buttonBar!)
        
        self.backButton = UIButton(frame:CGRectMake(10, 0, 200, 30))
        self.backButton!.setTitle("Voltar ao menu", forState: UIControlState.Normal)
        self.backButton?.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        self.backButton!.sizeToFit()
        self.backButton!.center.y = self.buttonBar!.bounds.height / 2
        self.backButton!.addTarget(self, action: "backButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.buttonBar!.addSubview(self.backButton!)
        
        generateQuestion()
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
    
    func backButtonAction() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func generateLaser () {
        
        var laser = UIView(frame: CGRectMake(0, 25, self.view.frame.width + self.view.bounds.width, 11))
        laser.backgroundColor = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 0.8)
        
        self.view.addSubview(laser)
        self.laser = laser
        self.laser?.superview?.bringSubviewToFront(self.laser!)
        
    }
    
    func generateQuestion () {
        
        self.score = 0
        
        self.labelWidth = self.view.bounds.width / 3
        self.labelHeight = 35
        
        self.leftBar = UIView(frame: CGRectMake(self.labelWidth!, -1, 3, self.view.bounds.height + self.view.frame.height))
        self.leftBar?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.leftBar!)
        
        self.rightBar = UIView(frame: CGRectMake(self.view.bounds.width - self.labelWidth!, -1, 3, self.view.bounds.height + self.view.frame.height))
        self.rightBar?.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.rightBar!)
        
        let pointX : CGFloat = view.bounds.width / 2 + self.leftBar!.bounds.width / 2 - (labelWidth! / 2)
        var pointY : CGFloat = 100
        
        var question = AccessJSON.accessTheQuestion(arrayOfData[level].level_type)
        
        var arrayOfOptions = AccessJSON.accessTheOptions(arrayOfData[level].level_type, question: question, level: self.difficulty)
        println(arrayOfOptions)
        
        var optionLeft = UILabel(frame: CGRectMake(0, 35, 100, 20))
        optionLeft.text = arrayOfOptions[0]
        optionLeft.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.8)
        self.view.addSubview(optionLeft)
        
        var optionRight = UILabel(frame: CGRectMake(300, 35, 100, 20))
        optionRight.text = arrayOfOptions[1]
        optionRight.backgroundColor = UIColor(red: 0, green: 1, blue: 1, alpha: 0.8)
        self.view.addSubview(optionRight)
        
        self.dictionaryOfAnswers = AccessJSON.accessTheAnswers(arrayOfData[level].level_type, question: question, level:self.difficulty, option1: String(stringInterpolationSegment : arrayOfOptions[0]), option2: String(stringInterpolationSegment: arrayOfOptions[1]))
        self.maxViews = dictionaryOfAnswers.count
        
        // Add the Views
        for i in 0..<self.maxViews {
            var newView = DraggableLabel(frame: CGRectMake(pointX, pointY, labelWidth!, labelHeight!))
            newView.text = dictionaryOfAnswers.keys.array[i]
            newView.textAlignment = NSTextAlignment.Center
            newView.layer.masksToBounds = true
            newView.layer.cornerRadius = 3
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
                    self.view.bringSubviewToFront(self.scoreReport!)
                    self.view.bringSubviewToFront(self.buttonBar!)
                    self.scoreReport!.text = String(format:"Você acertou\n%d de %d.", self.score, self.maxViews)
                    self.scoreReport!.textAlignment = .Center
                    self.scoreReport!.textColor = UIColor(red: 0.85, green: 0.65, blue: 0.2, alpha: 1)
                    self.scoreReport!.font = UIFont.systemFontOfSize(45)
                    self.scoreReport!.numberOfLines = 0
                    self.scoreReport!.lineBreakMode = NSLineBreakMode.ByWordWrapping
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        self.scoreReport!.frame.origin.y = self.view.center.y - self.scoreReport!.bounds.height
                        self.buttonBar!.frame.origin.y = self.view.center.y  + self.buttonBar!.bounds.height
                        self.laser!.alpha = 0
                        self.view.layoutIfNeeded()
                        }) { (result) -> Void in
                            
                    }
                    return
                }
        }
    }
    
}
