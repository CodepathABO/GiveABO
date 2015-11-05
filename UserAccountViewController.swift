//
//  UserAccountViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserAccountViewController: UIViewController {
    
    var screenOriginalCenter: CGPoint!
    
    var screenUp: CGPoint!
    var screenDown: CGPoint!
    
    var friction: CGFloat!



    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        menuScrollView.alpha = 1
        // settingsScrollView.alpha = 0
        
        screenUp = CGPoint(x: 0, y: 20)
        screenDown = CGPoint(x: 0, y: 580)
        
        contentView.frame.origin = screenUp
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSizeMake(0, -2)
        contentView.layer.shadowRadius = 2
        
        
        
        friction = 10


        // Do any additional setup after loading the view.
    }
    
    @IBAction func panGestureRecognizer(sender: UIPanGestureRecognizer) {
            
        
        var translation = sender.translationInView(view)
        
        let velocity = sender.velocityInView(view)
        
        let contentScale = convertValue(contentView.frame.origin.y, r1Min: 20, r1Max: 580, r2Min: 0.9, r2Max: 1.0)
        
        let contentFade = convertValue(contentView.frame.origin.y, r1Min: 20, r1Max: 580, r2Min: 0, r2Max: 1.0)
        
        if sender.state == UIGestureRecognizerState.Began {
            
            screenOriginalCenter = contentView.frame.origin
            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            if contentView.frame.origin.y < screenUp.y {
                
                translation.y /= friction
                
                
            }
            print(contentView.frame.origin.y)
            
            
            contentView.frame.origin = CGPoint(x: screenOriginalCenter.x, y: screenOriginalCenter.y + translation.y)
            
            self.contentView.layer.shadowOpacity = 0.2
            self.contentView.layer.shadowOffset = CGSizeMake(0, -4)
            self.contentView.layer.shadowRadius = 4
            
            menuScrollView.alpha = contentFade
            
            menuScrollView.transform = CGAffineTransformMakeScale(contentScale, contentScale)
            
            containerView.alpha = contentFade
            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            if velocity.y > 0 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
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
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.contentView.frame.origin = self.screenUp
                    UIView.animateWithDuration(0.2, animations: { () -> Void in
                       // self.arrow.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
                    })
                    }, completion: { (Bool) -> Void in
                        // ..
                })
                
            }
            
            if contentView.frame.origin.y == 580 {
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.containerView.alpha = 1
                    self.menuScrollView.alpha = 1
                    self.menuScrollView.transform = CGAffineTransformMakeScale(1.0, 1.0)
                })
            }
            
        } else if contentView.frame.origin.y == 20 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.containerView.alpha = 0
                self.menuScrollView.alpha = 0
                self.menuScrollView.transform = CGAffineTransformMakeScale(0.9, 0.9)
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
