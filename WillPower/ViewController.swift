//
//  ViewController.swift
//  WillPower
//
//  Created by Виталий Волков on 18.05.16.
//  Copyright © 2016 Виталий Волков. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    
    @IBOutlet weak var dHours: UILabel!
    @IBOutlet weak var custom: UIView!
    @IBOutlet weak var CustomMinutes: UILabel!
    @IBOutlet weak var CustomHours: UILabel!
    @IBOutlet weak var CustomDays: UILabel!
    @IBOutlet weak var CustomSeconds: UILabel!
    
    @IBOutlet weak var CustomTitle: UILabel!
    @IBOutlet weak var diet: UIView!
    @IBOutlet weak var DietMinutes: UILabel!
    @IBOutlet weak var DietHours: UILabel!
    @IBOutlet weak var DietDays: UILabel!
    
    @IBOutlet weak var DietSeconds: UILabel!
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var smoking: UIView!
    @IBOutlet weak var DMinutes: UILabel!
    @IBOutlet weak var Minutes: UILabel!
    @IBOutlet weak var drinking: UIView!
    @IBOutlet weak var Hours: UILabel!
    @IBOutlet weak var Days: UILabel!
    @IBOutlet weak var Seconds: UILabel!
    
    @IBOutlet weak var DSeconds: UILabel!
    @IBOutlet weak var nextConstr: NSLayoutConstraint!
    
    @IBOutlet weak var seccondConstr: NSLayoutConstraint!
    
    @IBOutlet weak var firstConstr: NSLayoutConstraint!
    
    @IBOutlet weak var indention: NSLayoutConstraint!
    
    @IBOutlet weak var indentionTwo: NSLayoutConstraint!
    
    @IBOutlet weak var indentionThree: NSLayoutConstraint!
    
    var startTimeDrink = NSTimeInterval()
    var startTimeSmoke = NSTimeInterval()
    var startTimeDiet = NSTimeInterval()
    var startTimeCustom = NSTimeInterval()
    var timerCustom = NSTimer()
    var timerDiet = NSTimer()
    var timerDrink = NSTimer()
    var timerSmoke = NSTimer()
    @IBOutlet weak var dDays: UILabel!
    var localNotification = UILocalNotification()
    var localNotification2 = UILocalNotification()
    var localNotification3 = UILocalNotification()
    var animateion : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopSmoking") as? String ?? "no" == "yes") {
            StopSmoking(1)
        }
        else
        {
            smoking.hidden = true
            
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopDrinking") as? String ?? "no" == "yes") {
            StopDrinking(1)
        }
        else
        {
            drinking.hidden = true
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopDiet") as? String ?? "no" == "yes") {
            StartDiet(1)
        }
        else
        {
            diet.hidden = true
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopCustom") as? String ?? "no" == "yes") {
            self.CustomStart()
            CustomTitle.text = NSUserDefaults.standardUserDefaults().valueForKey("CustomTitle") as? String ?? "Заголовок"
            custom.hidden = false
        }
        else
        {
            custom.hidden = true
        }
        
        if smoking.hidden == false || drinking.hidden == false || diet.hidden == false || custom.hidden == false{
            animateion = false
            viewDidAppear(true)
        }
        else{
        animateion = true
        viewDidAppear(true)
        }
        
        
                // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if  animateion == true{
            firstConstr.constant = 70
            seccondConstr.constant = 70
            nextConstr.constant = 70
            UIView.animateWithDuration(0.3){
                self.view.layoutSubviews()
            }
        }
        else
        {
         firstConstr.constant = 133
         nextConstr.constant = 133
         seccondConstr.constant = 133
         UIView.animateWithDuration(0.3){
            self.view.layoutSubviews()
        }
            
        }
        
    }
    
    
    @IBAction func StopDrinking(sender: AnyObject) {
        animateion = false
        viewDidAppear(true)
        drinking.hidden = false
        NSUserDefaults.standardUserDefaults().setObject("yes", forKey: "StopDrinking")
        if !timerDrink.valid {
            let aSelector : Selector = #selector(ViewController.updateTimeDrink)
            timerDrink = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeDrink = NSDate.timeIntervalSinceReferenceDate()
        }

    }
    
    @IBAction func StopSmoking(sender: AnyObject) {
//        self.firstConstr.constant = 133
//        UIView.animateWithDuration(0.3){
//            self.view.layoutSubviews()
//        }

        
//        if smoking.hidden == false && drinking.hidden == true && diet.hidden == true && custom.hidden == true{
        firstConstr.constant = 133
        nextConstr.constant = 133
        seccondConstr.constant = 133
        UIView.animateWithDuration(0.3){
            self.view.layoutSubviews()
        }

//        }
       
        NSUserDefaults.standardUserDefaults().setObject("yes", forKey: "StopSmoking")
        smoking.hidden = false
        
        if !timerSmoke.valid {
            let aSelector : Selector = #selector(ViewController.updateTime)
            timerSmoke = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeSmoke = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    @IBAction func CancelDrinking(sender: AnyObject) {
        SweetAlert().showAlert("Сорвались?", subTitle: "Время будет сброшено!", style: AlertStyle.Warning, buttonTitle:"Нет", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Да, я сорвался!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                print("Cancel Button  Pressed", terminator: "")
            }
            else {
                SweetAlert().showAlert("Сброшено!", subTitle: "Таймер аннулирован!", style: AlertStyle.Success)
                
                NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeDrink")
                NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopDrinking")
                self.timerDrink.invalidate()
                self.drinking.hidden = true
                if self.custom.hidden == false{
                    self.nextConstr.constant = 133
                }
                else{
                    self.animateion = true
                    self.viewDidAppear(true)
                }
               
                
                
                self.localNotification2.alertAction = "Проведите пальцем для разблокировки"
                self.localNotification2.alertBody = "Я не пью уже 1 день"
                self.localNotification2.timeZone = NSTimeZone.localTimeZone()
                self.localNotification2.fireDate = NSUserDefaults.standardUserDefaults().valueForKey("local2") as? NSDate
                UIApplication.sharedApplication().cancelLocalNotification(self.localNotification2)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
            let currentTime = NSDate.timeIntervalSinceReferenceDate()
            
            //Find the difference between current time and start time.
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeSmoke") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(currentTime, forKey: "startTimeSmoke")
            localNotification.alertAction = "Проведите пальцем для разблокировки"
            localNotification.alertBody = "Я не курю уже 1 день"
            localNotification.timeZone = NSTimeZone.localTimeZone()
            
            localNotification.fireDate = NSDate(timeIntervalSinceReferenceDate: currentTime + 86400.0)
            NSUserDefaults.standardUserDefaults().setValue(localNotification.fireDate, forKey: "local")
            
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            
        }
            let savedtime = NSUserDefaults.standardUserDefaults().doubleForKey("startTimeSmoke")
        
            //NSUserDefaults.standardUserDefaults().setObject(savedtime, forKey: "startTimeSmoke")
        
        
            var elapsedTime: NSTimeInterval = currentTime - savedtime
            //calculate the minutes in elapsed time.
            let days = Int(elapsedTime / 86400.0)
            
            elapsedTime -= NSTimeInterval((days) * 86400)
        
            let hours = Int(elapsedTime / 3600.0)
            
            elapsedTime -= NSTimeInterval((hours) * 3600)

            let minutes = Int(elapsedTime / 60.0)
            
            elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        
            
            //calculate the seconds in elapsed time.
            let seconds = UInt8(elapsedTime)
        
            elapsedTime -= NSTimeInterval(seconds)
        
            //find out the fraction of milliseconds to be displayed.
        
        
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            
            let strMinutes = String(format: "%02d", minutes)
            let strDays = String(format: "%02d", days)
            let strHours = String(format: "%02d", hours)
            let strSeconds = String(format: "%02d", seconds)
            
            //concatenate minuets, seconds and milliseconds as assign it to the UILabel
            Days.text = strDays
            Minutes.text = strMinutes
            Hours.text = strHours
            Seconds.text = strSeconds
            }

    func updateTimeDrink() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeDrink") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(currentTime, forKey: "startTimeDrink")
            
            localNotification2.alertAction = "Проведите пальцем для разблокировки"
            localNotification2.alertBody = "Я не пью уже 1 день"
            localNotification2.timeZone = NSTimeZone.localTimeZone()
            localNotification2.fireDate = NSDate(timeIntervalSinceReferenceDate: currentTime + 86400.0)
            NSUserDefaults.standardUserDefaults().setValue(localNotification2.fireDate, forKey: "local2")
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification2)
        }
        let savedtime = NSUserDefaults.standardUserDefaults().doubleForKey("startTimeDrink")
        
        var elapsedTime: NSTimeInterval = currentTime - savedtime
        //calculate the minutes in elapsed time.
        let days = Int(elapsedTime / 86400.0)
        
        elapsedTime -= NSTimeInterval((days) * 86400)
        
        let hours = Int(elapsedTime / 3600.0)
        
        elapsedTime -= NSTimeInterval((hours) * 3600)
        
        let minutes = Int(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        dDays.text = strDays
        DMinutes.text = strMinutes
        dHours.text = strHours
        DSeconds.text = strSeconds
        
    }
    
    
    

    @IBAction func StartDiet(sender: AnyObject) {
        if diet.hidden == true && smoking.hidden == true && drinking.hidden == true && custom.hidden == true{
            firstConstr.constant = 133
            nextConstr.constant = 133
            seccondConstr.constant = 133
            UIView.animateWithDuration(0.3){
                self.view.layoutSubviews()
            }

        }
        else{
//            firstConstr.constant = 70
//            nextConstr.constant = 70
//            seccondConstr.constant = 70
            UIView.animateWithDuration(0.3){
                self.view.layoutSubviews()
            }

        }
        
        NSUserDefaults.standardUserDefaults().setObject("yes", forKey: "StopDiet")
        diet.hidden = false
        if !timerDiet.valid {
            let aSelector : Selector = #selector(ViewController.updateTimeDiet)
            timerDiet = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeDiet = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    
    func updateTimeDiet() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeDiet") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(currentTime, forKey: "startTimeDiet")
            
            localNotification3.alertAction = "Проведите пальцем для разблокировки"
            localNotification3.alertBody = "Я на диете уже 1 день"
            localNotification3.timeZone = NSTimeZone.localTimeZone()
            
            localNotification3.fireDate = NSDate(timeIntervalSinceReferenceDate: currentTime + 86400.0)
            NSUserDefaults.standardUserDefaults().setValue(localNotification3.fireDate, forKey: "local3")
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification3)
        }
        let savedtime = NSUserDefaults.standardUserDefaults().doubleForKey("startTimeDiet")
        
        
        var elapsedTime: NSTimeInterval = currentTime - savedtime
        //calculate the minutes in elapsed time.
        let days = Int(elapsedTime / 86400.0)
        
        elapsedTime -= NSTimeInterval((days) * 86400)
        
        let hours = Int(elapsedTime / 3600.0)
        
        elapsedTime -= NSTimeInterval((hours) * 3600)
        
        let minutes = Int(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        DietDays.text = strDays
        DietMinutes.text = strMinutes
        DietHours.text = strHours
        DietSeconds.text = strSeconds
        
    }
    
     func CustomStart() {
        
        custom.hidden = false
        if custom.hidden == false && smoking.hidden == true && drinking.hidden == true && diet.hidden == true{
            firstConstr.constant = 70
            seccondConstr.constant = 70
        }
        else{
            animateion = false
            viewDidAppear(true)
        }
        if !timerCustom.valid {
            let aSelector : Selector = #selector(ViewController.updateTimeCustom)
            timerCustom = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeCustom = NSDate.timeIntervalSinceReferenceDate()
        }
        
        

    }
    
    @IBAction func CancelCustom(sender: AnyObject) {
        
        SweetAlert().showAlert("Сорвались?", subTitle: "Время будет сброшено!", style: AlertStyle.Warning, buttonTitle:"Нет", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Да, я сорвался!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                print("Cancel Button  Pressed", terminator: "")
            }
            else {
                SweetAlert().showAlert("Сброшено!", subTitle: "Таймер аннулирован!", style: AlertStyle.Success)
                NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeCustom")
                NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopCustom")
                self.timerCustom.invalidate()
                self.custom.hidden = true
                if self.drinking.hidden == false{
                    self.firstConstr.constant = 133
                }
                else{
                    self.animateion = true
                    self.viewDidAppear(true)
                }

            }
        }
    }
    
    func updateTimeCustom() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeCustom") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(currentTime, forKey: "startTimeCustom")
        }
        let savedtime = NSUserDefaults.standardUserDefaults().doubleForKey("startTimeCustom")
        
        var elapsedTime: NSTimeInterval = currentTime - savedtime
        //calculate the minutes in elapsed time.
        let days = Int(elapsedTime / 86400.0)
        
        elapsedTime -= NSTimeInterval((days) * 86400)
        
        let hours = Int(elapsedTime / 3600.0)
        
        elapsedTime -= NSTimeInterval((hours) * 3600)
        
        let minutes = Int(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        let strSeconds = String(format: "%02d", seconds)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        CustomDays.text = strDays
        CustomMinutes.text = strMinutes
        CustomHours.text = strHours
        CustomSeconds.text = strSeconds
        
    }

    
    @IBAction func CancelDiet(sender: AnyObject) {
        
        SweetAlert().showAlert("Сорвались?", subTitle: "Время будет сброшено!", style: AlertStyle.Warning, buttonTitle:"Нет", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Да, я сорвался!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                print("Cancel Button  Pressed", terminator: "")
            }
            else {
                SweetAlert().showAlert("Сброшено!", subTitle: "Таймер аннулирован!", style: AlertStyle.Success)
                NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeDiet")
                NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopDiet")
                self.timerDiet.invalidate()
                self.diet.hidden = true
                if self.custom.hidden == false || self.drinking.hidden == false{
                    self.nextConstr.constant = 133
                    self.firstConstr.constant = 133
                }
                else {
                    self.animateion = true
                    self.viewDidAppear(true)
                }
                self.localNotification3.alertAction = "Проведите пальцем для разблокировки"
                self.localNotification3.alertBody = "Я на диете уже 1 день"
                self.localNotification3.timeZone = NSTimeZone.localTimeZone()
                
                self.localNotification3.fireDate = NSUserDefaults.standardUserDefaults().valueForKey("local3") as? NSDate
                
                
                UIApplication.sharedApplication().cancelLocalNotification(self.localNotification3)
            }
        }
    }
    
    @IBAction func CancelSmoking(sender: AnyObject) {
        
        
        SweetAlert().showAlert("Сорвались?", subTitle: "Время будет сброшено!", style: AlertStyle.Warning, buttonTitle:"Нет", buttonColor:UIColor.colorFromRGB(0xD0D0D0) , otherButtonTitle:  "Да, я сорвался!", otherButtonColor: UIColor.colorFromRGB(0xDD6B55)) { (isOtherButton) -> Void in
            if isOtherButton == true {
                
                print("Cancel Button  Pressed", terminator: "")
            }
            else {
                SweetAlert().showAlert("Сброшено!", subTitle: "Таймер аннулирован!", style: AlertStyle.Success)
                NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeSmoke")
                NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopSmoking")
                self.timerSmoke.invalidate()
                self.smoking.hidden = true
                if self.drinking.hidden == false || self.custom.hidden == false{
                    self.firstConstr.constant = 133
                    self.nextConstr.constant = 133
                }
                else{
                    self.animateion = true
                    self.viewDidAppear(true)
                }

                self.localNotification.alertAction = "Проведите пальцем для разблокировки"
                self.localNotification.alertBody = "Я не курю уже 1 день"
                self.localNotification.timeZone = NSTimeZone.localTimeZone()
                
                self.localNotification.fireDate = NSUserDefaults.standardUserDefaults().valueForKey("local") as? NSDate
                
                
                UIApplication.sharedApplication().cancelLocalNotification(self.localNotification)
            }
        }
    }
    
    
    @IBAction func addCounter(seder: UIButton){
        custom.hidden = true
        if custom.hidden == false && smoking.hidden == true && drinking.hidden == true && diet.hidden == true{
            firstConstr.constant = 70
            seccondConstr.constant = 70
        }
        else{
            animateion = false
            viewDidAppear(true)
        }
        }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden =  true
        
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

