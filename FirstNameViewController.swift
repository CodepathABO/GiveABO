//
//  FirstNameViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class FirstNameViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var firstNameField: UITextField!
    
    var initialY: CGFloat!
    var offset: CGFloat!
    
    var firstName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        initialY = continueButton.frame.origin.y
        offset = -240
        
        firstName = "hello"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        continueButton.layer.cornerRadius = 25
        continueButton.layer.borderColor = UIColor.redColor().CGColor
        continueButton.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        continueButton.frame.origin.y = initialY + offset

        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        continueButton.frame.origin.y = initialY
        
    }
    
    
    @IBAction func onEditFirstName(sender: AnyObject) {
        
        continueButton.layer.cornerRadius = 25
        continueButton.titleLabel!.textColor = UIColor.whiteColor()
        continueButton.layer.borderWidth = 1
        continueButton.layer.backgroundColor =
            UIColor.redColor().CGColor
        
        firstName = firstNameField.text
        
        print("\(firstName)")
        
    }
    
    

    @IBAction func onContinue(sender: AnyObject) {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(firstName, forKey: "first_name")
        defaults.synchronize()
        
        /*
        
        UIView.animateWithDuration(10,
            delay:0.4,
            options:UIViewAnimationOptions.Repeat,
            animations: { () -> Void in
            self.continueButton.alpha = 0
            /*
            self.continueButton.alpha = 1
            self.continueButton.alpha = 0.5
            self.continueButton.alpha = 1
            */},
            completion: {
                (finished: Bool) -> Void in
            
            print("hello")
                
            UIView.animateWithDuration(1.0,
                    delay: 0.0,
                    options: UIViewAnimationOptions.CurveEaseIn,
                    animations: { () -> Void in
                        self.performSegueWithIdentifier("NameToBlood", sender: self)}, completion: nil)
                
            
            
        })
        
        */
        
        self.performSegueWithIdentifier("NameToBlood", sender: nil)
        
    }
    
    @IBAction func onBack(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        
        
    }
    
    
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
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
