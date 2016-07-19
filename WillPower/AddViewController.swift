//
//  AddViewController.swift
//  WillPower
//
//  Created by Виталий Волков on 19.05.16.
//  Copyright © 2016 Виталий Волков. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        CustomTitle.delegate = self
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.CustomTitle.frame.height))
        CustomTitle.leftView = paddingView
        CustomTitle.leftViewMode = UITextFieldViewMode.Always
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var CustomTitle: UITextField!
    
    @IBAction func AddButton(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setObject(self.CustomTitle.text, forKey: "CustomTitle")
        NSUserDefaults.standardUserDefaults().setObject("yes", forKey: "StopCustom")
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
