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
        
        for i in 0...18 {
            
            let platelet = UIView()
            platelet.frame = CGRect(x: 55, y: 300, width: 100, height: 100)
            platelet.backgroundColor = UIColor(red:0.76, green:0.18, blue:0.18, alpha:0.9)
            platelet.layer.cornerRadius = 50
            
            self.view.addSubview(platelet)
            
            let randomYOffset = CGFloat(arc4random_uniform(150))
            
            let path = UIBezierPath()
            path.moveToPoint(CGPoint(x: -106, y: 439 + randomYOffset))
            path .addCurveToPoint(CGPoint(x: 481, y: 539 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 473 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 310 + randomYOffset))
            
            
            
            let anim = CAKeyframeAnimation(keyPath: "position")
            
            anim.path = path.CGPath
            
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = Double(arc4random_uniform(40)+30) / 7
            anim.timeOffset = Double(arc4random_uniform(90))
            
            platelet.layer.addAnimation(anim, forKey: "animate position along path")
            
            self.view.sendSubviewToBack(platelet)
            
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
