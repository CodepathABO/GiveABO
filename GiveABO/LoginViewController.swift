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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var registerCheckView: UIView!
    @IBOutlet weak var registeredLabel: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    
    var signupActive = false
    
    var initialY: CGFloat!
    let offset: CGFloat = -100
    
    var cancelInitialY: CGFloat!
    let cancelOffset: CGFloat = -180
    
    var registeredInitialY: CGFloat!
    let registeredOffset: CGFloat = -100
    
    var forgotInitialY: CGFloat!
    let forgotOffset: CGFloat = -100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = true

        loginButton.layer.cornerRadius = 25
        
        usernameField.delegate = self
        passwordField.delegate = self
        
        usernameField.becomeFirstResponder()
        
        usernameField.attributedPlaceholder = NSAttributedString(string:"Username",
            attributes:[NSForegroundColorAttributeName: UIColor(red:0.53, green:0.05, blue:0.00, alpha:1.0)])
        
        passwordField.attributedPlaceholder = NSAttributedString(string:"Password",
            attributes:[NSForegroundColorAttributeName: UIColor(red:0.53, green:0.05, blue:0.00, alpha:1.0)])
        
        initialY = loginView.frame.origin.y
        registeredInitialY = registerCheckView.frame.origin.y
        forgotInitialY = forgotPassword.frame.origin.y
        cancelInitialY = cancelButton.frame.origin.y
        
        activityIndicator.hidesWhenStopped = true

        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        
        

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.loginView.frame.origin.y = 110
            
            
            }) { (Bool) -> Void in
                // ..
        }
        
        
        
        
    }

    @IBAction func loginButtonDidTouch(sender: UIButton) {
        
        // On Empty Fields
        
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
            
        } else {
        
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            activityIndicator.startAnimating()
            
            
            var errorMessage = "Please try again later"
            
            // On Sign Up
            
            if signupActive == true {
                
                var user = PFUser()
                user.username = usernameField.text
                user.password = passwordField.text
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, error: NSError?) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if let error = error {
                        let errorString = error.userInfo["error"] as? String
                        
                        
                        print("error")
                        
                        errorMessage = errorString!
                        
                        self.displayAlert("Failed signup", message: errorMessage)
                        
                    } else {
                        // Hooray! Let them use the app now.
                        
                        self.goToHome()
                    }
                    
                }
                
            } else {

            // On Log In
        
        PFUser.logInWithUsernameInBackground(usernameField.text!, password:passwordField.text!) {
            (user: PFUser?, error: NSError?) -> Void in
            
            self.activityIndicator.stopAnimating()
            UIApplication.sharedApplication().endIgnoringInteractionEvents()
            
            if user != nil {
                
                // Do stuff after successful login.
                
                self.goToHome()

                
                print("YAY!")
                
            } else {
                
                // The login failed. Check error to see why.
                
                if let error = error {
                    let errorString = error.userInfo["error"] as? String
                    
                    
                    print("error")
                    
                    errorMessage = errorString!
                    
                    self.displayAlert("Failed Login", message: errorMessage)
                    }
                    
                }
                
            }
        }
        
        }
    }
    
    // Swap the Sign Up - Log In
    
    @IBAction func signUpButtonDidTouch(sender: UIButton) {
        
        if signupActive == false {
            
            
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            
            registeredLabel.text = "Already registered?"
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            
            signupActive = true
            
            goToSignup()
            
            
        } else {
             loginButton.setTitle("Log In", forState: UIControlState.Normal)
            
            registeredLabel.text = "Not registered?"
            
            signupButton.setTitle("Sign In", forState: UIControlState.Normal)
            
            signupActive = false
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
        registerCheckView.frame.origin = CGPoint(x: registerCheckView.frame.origin.x, y: registeredInitialY + forgotOffset)
        cancelButton.frame.origin = CGPoint(x: cancelButton.frame.origin.x, y: cancelInitialY + cancelOffset)
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        loginView.frame.origin = CGPoint(x: loginView.frame.origin.x, y: initialY)
        forgotPassword.frame.origin = CGPoint(x: forgotPassword.frame.origin.x, y: forgotInitialY)
        registerCheckView.frame.origin = CGPoint(x: registerCheckView.frame.origin.x, y: registeredInitialY)
        cancelButton.frame.origin = CGPoint(x: cancelButton.frame.origin.x, y: cancelInitialY)
        
    }
    
    // Dismisses the keyboard when you press return (the bottom right key)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            // ...
        }
        alert.addAction(OKAction)
        
        self.presentViewController(alert, animated: true) {
            // ...
        }
    }
    
    func goToHome() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SBTestViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
        
    }
    
    // GO TO SIGNUP STORYBOARD
    func goToSignup() {
        
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpNavigationViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Slide)
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
