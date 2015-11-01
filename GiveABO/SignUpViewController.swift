//
//  SignUpViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 10/31/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var mainViewContainer: UIView!
    @IBOutlet weak var logoPlateletView: UIView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewContainer.alpha = 0
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        UIApplication.sharedApplication().statusBarHidden = false
        
        logoPlateletView.layer.cornerRadius = logoPlateletView.frame.size.width / 2
        signUpButton.layer.cornerRadius = 25
        loginButton.layer.cornerRadius = 25
        loginButton.layer.borderColor = UIColor.whiteColor().CGColor
        loginButton.layer.borderWidth = 1
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.mainViewContainer.alpha = 1
            
            }) { (Bool) -> Void in
                
                //..
        }
        
    }
    
    @IBAction func signUpButtonDidTouch(sender: UIButton) {
        performSegueWithIdentifier("onboardSegue", sender: self)
    
    }
    
    
    @IBAction func loginButtonDidTouch(sender: UIButton) {
        performSegueWithIdentifier("loginSegue", sender: self)
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
