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
    @IBOutlet weak var CustomTitle: UILabel!
    @IBOutlet weak var diet: UIView!
    @IBOutlet weak var DietMinutes: UILabel!
    @IBOutlet weak var DietHours: UILabel!
    @IBOutlet weak var DietDays: UILabel!
    @IBOutlet weak var Cancel: UIButton!
    @IBOutlet weak var smoking: UIView!
    @IBOutlet weak var DMinutes: UILabel!
    @IBOutlet weak var Minutes: UILabel!
    @IBOutlet weak var drinking: UIView!
    @IBOutlet weak var Hours: UILabel!
    @IBOutlet weak var Days: UILabel!
    var startTimeDrink = NSTimeInterval()
    var startTimeSmoke = NSTimeInterval()
    var startTimeDiet = NSTimeInterval()
    var startTimeCustom = NSTimeInterval()
    var timerCustom = NSTimer()
    var timerDiet = NSTimer()
    var timerDrink = NSTimer()
    var timerSmoke = NSTimer()
    @IBOutlet weak var dDays: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopSmoking") as? String ?? "no" == "yes") {
            StopSmoking(Days)
            
        }
        else
        {
            smoking.hidden = true
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopDrinking") as? String ?? "no" == "yes") {
            StopDrinking(Days)
        }
        else
        {
            drinking.hidden = true
        }
        if (NSUserDefaults.standardUserDefaults().valueForKey("StopDiet") as? String ?? "no" == "yes") {
            StartDiet(Days)
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

        
                // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func StopDrinking(sender: AnyObject) {
        drinking.hidden = false
        NSUserDefaults.standardUserDefaults().setObject("yes", forKey: "StopDrinking")
        if !timerDrink.valid {
            let aSelector : Selector = #selector(ViewController.updateTimeDrink)
            timerDrink = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeDrink = NSDate.timeIntervalSinceReferenceDate()
        }

    }
    @IBAction func StopSmoking(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setObject("yes", forKey: "StopSmoking")
        smoking.hidden = false
        if !timerSmoke.valid {
            let aSelector : Selector = #selector(ViewController.updateTime)
            timerSmoke = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeSmoke = NSDate.timeIntervalSinceReferenceDate()
        }
    }
    @IBAction func CancelDrinking(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeDrink")
        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopDrinking")
        drinking.hidden = true
        timerDrink.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTime() {
            let currentTime = NSDate.timeIntervalSinceReferenceDate()
            
            //Find the difference between current time and start time.
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeSmoke") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(startTimeSmoke, forKey: "startTimeSmoke")
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
            
                    
            //find out the fraction of milliseconds to be displayed.
            
            
            
            //add the leading zero for minutes, seconds and millseconds and store them as string constants
            
            let strMinutes = String(format: "%02d", minutes)
            let strDays = String(format: "%02d", days)
            let strHours = String(format: "%02d", hours)
            
            //concatenate minuets, seconds and milliseconds as assign it to the UILabel
            Days.text = strDays
            Minutes.text = strMinutes
            Hours.text = strHours
        
            }

    func updateTimeDrink() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        //Find the difference between current time and start time.
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeDrink") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(startTimeDrink, forKey: "startTimeDrink")
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
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        dDays.text = strDays
        DMinutes.text = strMinutes
        dHours.text = strHours
        
    }

    @IBAction func StartDiet(sender: AnyObject) {
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
            NSUserDefaults.standardUserDefaults().setDouble(startTimeDiet, forKey: "startTimeDiet")
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
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        DietDays.text = strDays
        DietMinutes.text = strMinutes
        DietHours.text = strHours
        
    }
    
     func CustomStart() {
        custom.hidden = false
        if !timerCustom.valid {
            let aSelector : Selector = #selector(ViewController.updateTimeCustom)
            timerCustom = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector,     userInfo: nil, repeats: true)
            startTimeCustom = NSDate.timeIntervalSinceReferenceDate()
        }

    }
    
    @IBAction func CancelCustom(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeDiet")
        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopCustom")
        custom.hidden = true
        timerDiet.invalidate()
    }
    
    func updateTimeCustom() {
        
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        if (NSUserDefaults.standardUserDefaults().doubleForKey("startTimeCustom") == 0.0) {
            NSUserDefaults.standardUserDefaults().setDouble(startTimeCustom, forKey: "startTimeCustom")
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
        
        //add the leading zero for minutes, seconds and millseconds and store them as string constants
        
        let strMinutes = String(format: "%02d", minutes)
        let strDays = String(format: "%02d", days)
        let strHours = String(format: "%02d", hours)
        
        //concatenate minuets, seconds and milliseconds as assign it to the UILabel
        CustomDays.text = strDays
        CustomMinutes.text = strMinutes
        CustomHours.text = strHours
        
    }

    
    @IBAction func CancelDiet(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeDiet")
        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopDiet")
        diet.hidden = true
        timerDiet.invalidate()
    }
    
    @IBAction func CancelSmoking(sender: AnyObject) {
        NSUserDefaults.standardUserDefaults().setDouble(0.0, forKey: "startTimeSmoke")
        NSUserDefaults.standardUserDefaults().setObject("no", forKey: "StopSmoking")
        smoking.hidden = true
        timerSmoke.invalidate()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden =  true
        
        UIApplication.sharedApplication().statusBarHidden = false
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
}

