//
//  UserInfoViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/4/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserInfoViewController: UIViewController {

    @IBOutlet weak var navScrollView: UIScrollView!
    @IBOutlet weak var accountViewContain: UIView!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var totalDonationsContain: UIView!
    @IBOutlet weak var containerView: UIView!
    
    var screenOriginalCenter: CGPoint!
    
    var screenUp: CGPoint!
    var screenDown: CGPoint!
    
    var friction: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navScrollView.alpha = 1
        
        
        screenUp = CGPoint(x: 0, y: 20)
        screenDown = CGPoint(x: 0, y: 600)
        
        accountViewContain.frame.origin = screenUp
        accountViewContain.layer.shadowOpacity = 0.4
        accountViewContain.layer.shadowOffset = CGSizeMake(0, -2)
        accountViewContain.layer.shadowRadius = 2

        
        friction = 10
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onScreenPan(sender: UIPanGestureRecognizer) {
        
        
        var translation = sender.translationInView(view)
        
        let velocity = sender.velocityInView(view)
        
        let contentScale = convertValue(accountViewContain.frame.origin.y, r1Min: 20, r1Max: 600, r2Min: 0.9, r2Max: 1.0)
        
        let contentFade = convertValue(accountViewContain.frame.origin.y, r1Min: 20, r1Max: 600, r2Min: 0, r2Max: 1.0)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            // ...
            
            screenOriginalCenter = accountViewContain.frame.origin
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            // ..
            
            if accountViewContain.frame.origin.y < screenUp.y {
                
                translation.y /= friction
                
                
            }
            print(accountViewContain.frame.origin.y)
            
            
            accountViewContain.frame.origin = CGPoint(x: screenOriginalCenter.x, y: screenOriginalCenter.y + translation.y)
            
            self.accountViewContain.layer.shadowOpacity = 0.2
            self.accountViewContain.layer.shadowOffset = CGSizeMake(0, -4)
            self.accountViewContain.layer.shadowRadius = 4
            
            containerView.alpha = contentFade
            
            navScrollView.transform = CGAffineTransformMakeScale(contentScale, contentScale)
            
            containerView.alpha = contentFade
            
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            // ..
            
            if velocity.y > 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.accountViewContain.frame.origin = self.screenDown
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        // self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))
                        self.accountViewContain.layer.shadowOpacity = 0.2
                        self.accountViewContain.layer.shadowOffset = CGSizeMake(0, -1)
                        self.accountViewContain.layer.shadowRadius = 1
                    })
                    }, completion: { (Bool) -> Void in
                        // ..
                })
                
            } else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.accountViewContain.frame.origin = self.screenUp
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                        // self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
                    })
                    }, completion: { (Bool) -> Void in
                        // ..
                })
                
            }
            
            if accountViewContain.frame.origin.y == 600 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.accountViewContain.alpha = 1
                    self.navScrollView.alpha = 1
                    self.navScrollView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
            }
            
        } else if accountViewContain.frame.origin.y == 20 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.accountViewContain.alpha = 0
                self.navScrollView.alpha = 0
                self.navScrollView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            })
        }
        

            
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
