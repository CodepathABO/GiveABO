//
//  UserAccountViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserAccountViewController: UIViewController {


    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    
    @IBOutlet var buttons: [UIButton]!
    
    
    var userProfileViewController: UIViewController!
    var userRewardsViewController: UIViewController!
    var userEventsViewController: UIViewController!
    var userStoriesViewController: UIViewController!
    
    var viewControllers: [UIViewController]!
    
    var selectedIndex: Int = 0
    
    
    var screenOriginalCenter: CGPoint!
    
    var screenUp: CGPoint!
    var screenDown: CGPoint!
    
    var friction: CGFloat!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        menuScrollView.alpha = 1
        // settingsScrollView.alpha = 0
        
        screenUp = CGPoint(x: 0, y: 20)
        screenDown = CGPoint(x: 290, y: 20)
        
        contentView.frame.origin = screenUp
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSizeMake(-2, 0)
        contentView.layer.shadowRadius = 2
        
        friction = 10


        let storyboard = UIStoryboard(name: "Main", bundle:  nil)
        
        userProfileViewController = storyboard.instantiateViewControllerWithIdentifier("UserProfileViewController")
        userRewardsViewController = storyboard.instantiateViewControllerWithIdentifier("UserRewardsViewController")
        userEventsViewController = storyboard.instantiateViewControllerWithIdentifier("UserEventsViewController")
        userStoriesViewController = storyboard.instantiateViewControllerWithIdentifier("UserStoriesViewController")
        
        
        viewControllers = [userProfileViewController, userRewardsViewController, userEventsViewController, userStoriesViewController]
        
        buttons[selectedIndex].selected = true
        navButtons(buttons[selectedIndex])

    }
    
    @IBAction func navButtons(sender: UIButton) {
        
        
        let previousIndex = selectedIndex
        
        selectedIndex = sender.tag
        
        buttons[previousIndex].selected = false
        
        let previousVC = viewControllers[previousIndex]
        
        previousVC.willMoveToParentViewController(nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()
        
        sender.selected = true
        
        let vc = viewControllers[selectedIndex]
        
        addChildViewController(vc)
        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        
        vc.didMoveToParentViewController(self)
        
        UIView.animateWithDuration(0.5, delay: 0.65, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.contentView.frame.origin = self.screenUp
            
            }) { (Bool) -> Void in
                // ..
        }

        
        
    }
    
    
    
    // MARK: View Slide to Expose Nav Gesture Recognizer
    
    @IBAction func panGestureRecognizer(sender: UIPanGestureRecognizer) {
            
        
        var translation = sender.translationInView(view)
        
        let velocity = sender.velocityInView(view)
        
        let contentScale = convertValue(contentView.frame.origin.x, r1Min: 20, r1Max: 290, r2Min: 0.9, r2Max: 1.0)
        
        let contentFade = convertValue(contentView.frame.origin.x, r1Min: 20, r1Max: 290, r2Min: 0, r2Max: 1.0)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            screenOriginalCenter = contentView.frame.origin
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            if contentView.frame.origin.x < screenUp.x {
                
                translation.x /= friction
                
                
            }
            print(contentView.frame.origin.y)
            
            contentView.frame.origin = CGPoint(x: screenOriginalCenter.x + translation.x, y: screenOriginalCenter.y)
            // contentView.frame.origin = CGPoint(x: screenOriginalCenter.x, y: screenOriginalCenter.y + translation.y)
            
            self.contentView.layer.shadowOpacity = 0.2
            self.contentView.layer.shadowOffset = CGSizeMake(-4, 0)
            self.contentView.layer.shadowRadius = 4
            
            menuScrollView.alpha = contentFade
            
            menuScrollView.transform = CGAffineTransformMakeScale(contentScale, contentScale)
            
            containerView.alpha = contentFade
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.x > 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.contentView.frame.origin = self.screenDown
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                       // self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(180 * M_PI / 180))
                        self.contentView.layer.shadowOpacity = 0.2
                        self.contentView.layer.shadowOffset = CGSizeMake(0, -1)
                        self.contentView.layer.shadowRadius = 1
                    })
                    }, completion: { (Bool) -> Void in
                        // ..
                })
                
            } else {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.contentView.frame.origin = self.screenUp
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                       // self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
                    })
                    }, completion: { (Bool) -> Void in
                        // ..
                })
                
            }
            
            if contentView.frame.origin.x == 290 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.alpha = 1
                    self.menuScrollView.alpha = 1
                    self.menuScrollView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
            }
            
        } else if contentView.frame.origin.x == 20 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.containerView.alpha = 0
                self.menuScrollView.alpha = 0
                self.menuScrollView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            })
        }

            
    }
    
    
    @IBAction func donateButton(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func requestButton(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func privacyButton(sender: UIButton) {
        performSegueWithIdentifier("privacySegue", sender: self)
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
