//
//  LoginViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 10/31/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var initialY: CGFloat!
    let offset: CGFloat = -100
    
    var cancelInitialY: CGFloat!
    let cancelOffset: CGFloat = -180
    
    var forgotInitialY: CGFloat!
    let forgotOffset: CGFloat = -100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 25
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.becomeFirstResponder()
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        initialY = loginView.frame.origin.y
        forgotInitialY = forgotPassword.frame.origin.y
        cancelInitialY = cancelButton.frame.origin.y
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.loginView.frame.origin.y = 220
            
            
            }) { (Bool) -> Void in
                // ..
        }
        
        
    }

    @IBAction func loginButtonDidTouch(sender: UIButton) {
        
        if usernameField.text == "" && passwordField.text == "" {
            
            UIView.animateWithDuration(0.1, delay: 0.1, options: [], animations: { () -> Void in
                self.loginView.frame.origin.x = 5
                }, completion: { (Bool) -> Void in
                    UIView.animateWithDuration(0.1, delay: 0, options: [], animations: { () -> Void in
                        self.loginView.frame.origin.x = 35
                        }, completion: { (Bool) -> Void in
                            UIView.animateWithDuration(0.1, delay: 0, options: [], animations: { () -> Void in
                                self.loginView.frame.origin.x = 20
                                }, completion: nil)
                    })
            })
            
        }
        
        if usernameField.text == "x" && passwordField.text == "x" {
           //  performSegueWithIdentifier("requestsSegue", sender: self)
            
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            
            let controller = storyboard.instantiateViewControllerWithIdentifier("SBTestViewController") as UIViewController
            
            self.presentViewController(controller, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelButtonDidTouch(sender: UIButton) {
        loginView.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        loginView.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        loginView.frame.origin = CGPoint(x: loginView.frame.origin.x, y: initialY + offset)
        forgotPassword.frame.origin = CGPoint(x: forgotPassword.frame.origin.x, y: forgotInitialY + forgotOffset)
        
        cancelButton.frame.origin = CGPoint(x: cancelButton.frame.origin.x, y: cancelInitialY + cancelOffset)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        loginView.frame.origin = CGPoint(x: loginView.frame.origin.x, y: initialY)
        forgotPassword.frame.origin = CGPoint(x: forgotPassword.frame.origin.x, y: forgotInitialY)
        
        cancelButton.frame.origin = CGPoint(x: cancelButton.frame.origin.x, y: cancelInitialY)
        
    }
    
    // Dismisses the keyboard when you press return (the bottom right key)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        modalPresentationStyle = UIModalPresentationStyle.Custom
        transitioningDelegate = self
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
