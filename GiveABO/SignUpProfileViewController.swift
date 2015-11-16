//
//  SignUpProfileViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class SignUpProfileViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginContainer: UIView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var initialY: CGFloat!
    var offset: CGFloat!
    
    var initialLoginContainY: CGFloat!
    var offsetLoginContain: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.usernameField.becomeFirstResponder()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        initialY = signupButton.frame.origin.y
        offset = -214
        
        initialLoginContainY = loginContainer.frame.origin.y
        offsetLoginContain = -214
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

        signupButton.layer.cornerRadius = 25
        signupButton.layer.borderWidth = 1
        signupButton.backgroundColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        signupButton.layer.borderColor = UIColor.redColor().CGColor
        usernameField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(notification: NSNotification!) {
        
        signupButton.frame.origin.y = initialY + offset
        loginContainer.frame.origin.y = initialLoginContainY + offsetLoginContain
        
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        
        signupButton.frame.origin.y = initialY
        loginContainer.frame.origin.y = initialLoginContainY
    }

    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }

    @IBAction func onSignupPressed(sender: UIButton) {
        
        if usernameField.text == "" || passwordField.text == "" || confirmPasswordField.text == "" {
            
            displayAlert("Login Error", message: "One or more required fields have been left blank")
            
        } else if passwordField.text != confirmPasswordField.text {
            
            displayAlert("Login Error", message: "Passwords do not match")
        
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            
            activityIndicator.center.y = 380
            activityIndicator.center.x = 320
            
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
            
            var errorMessage = "Please try again later"
            
           
                
                
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
                        
                        // self.performSegueWithIdentifier("parseit", sender: self)
                        self.performSegueWithIdentifier("SignupToFirstName", sender: nil)
                    }
                    
                }
                
            }
        }


    @IBAction func loginButtonDidTouch(sender: UIButton) {
        
        goToLogin()
    
    }
    
    @IBAction func dismissButton(sender: UIButton) {
        view.endEditing(true)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
           // self.dismissViewControllerAnimated(true, completion: nil)
            
        })))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func goToLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("LogOutViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
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
