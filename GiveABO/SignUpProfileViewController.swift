//
//  SignUpProfileViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class SignUpProfileViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    var initialY: CGFloat!
    var offset: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.usernameField.becomeFirstResponder()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        initialY = signupButton.frame.origin.y
        offset = -240
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        signupButton.layer.cornerRadius = 25
        signupButton.layer.borderWidth = 1
        signupButton.backgroundColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        signupButton.layer.borderColor = UIColor.redColor().CGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        signupButton.frame.origin.y = initialY + offset
        
        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        signupButton.frame.origin.y = initialY
        
    }

    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }

    @IBAction func onSignupPressed(sender: UIButton) {
        self.performSegueWithIdentifier("SignupToFirstName", sender: nil)
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
