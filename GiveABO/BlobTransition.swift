//
//  BlobTransition.swift
//  abo-v2
//
//  Created by Sybico, Christopher on 10/31/15.
//  Copyright © 2015 Sybico, Christopher. All rights reserved.
//

import UIKit

class BlobTransition: BaseTransition {
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // SET UP FROM AND TO
        let requestDetialVC = toViewController as! RequestDetailViewController
        let homeVC = fromViewController as! HomeViewController
        
        let requestView = requestDetialVC.requestView
        
        // SETUP REQUEST IN DETAL VIEW
        // REQUEST VIEW'S INITIAL FRAME IS SIMILAR TO INITIAL BLOB FRAME
        requestView.frame.size = homeVC.selectedBloblFrame.size
        requestView.frame.origin.x = homeVC.selectedView.frame.origin.x + homeVC.selectedBloblFrame.origin.x
        requestView.frame.origin.y = homeVC.selectedView.frame.origin.y + homeVC.selectedBloblFrame.origin.y
        
        // ADD SCROLL OFFSET FROM HOME
        requestView.frame.origin.x -= homeVC.homeScrollViewOffsetX
        
        // DISPLAY REQUEST IN DETAIL VIEW
        requestDetialVC.view.addSubview(requestView)
        requestDetialVC.view.sendSubviewToBack(requestView)
        
        // SETUP BLOB IMAGE VIEW
        let blobImageView = UIImageView (image: requestDetialVC.blobImage)
        requestView.addSubview(blobImageView)
        
        
        // HIDE SELECTED VIEW IN HOME
        homeVC.selectedView.alpha = 0
        
        
        // ANIMATE
        UIView.animateWithDuration(
            
            duration,
            delay: 0,
            usingSpringWithDamping: 1.2,
            initialSpringVelocity: 0.8,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                
                requestView.center = CGPoint(x: 140, y: 270)
                requestView.transform = CGAffineTransformMakeScale(6, 6)
                
            }
            )
            {
                (finished: Bool) -> Void in
                self.finish()
        }
    
        // self.finish()
    }
    
    //
    //
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        // SET UP FROM AND TO
        let requestDetialVC = fromViewController as! RequestDetailViewController
        let homeVC = toViewController as! HomeViewController
        
        let requestView = requestDetialVC.requestView
        
        
        
        // FADE OUT CONTENTS
        
        var delay = 0.0
        
        for content in requestDetialVC.requestContents {
            
            UIView.animateWithDuration(
                0.1,
                delay: delay,
                options: UIViewAnimationOptions.CurveEaseIn,
                animations: { () -> Void in
                    content.alpha = 0
                    requestDetialVC.donateButton.alpha = 0
                },
                completion: nil
            )
            delay += 0.05
        }
        
        
        // ANIMATE
        UIView.animateWithDuration(
            
            duration,
            delay: 0.5,
            usingSpringWithDamping: 1.2,
            initialSpringVelocity: 0.8,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                
                requestView.transform = CGAffineTransformMakeScale(1, 1)
                requestView.frame.origin.x = homeVC.selectedView.frame.origin.x + homeVC.selectedBloblFrame.origin.x
                requestView.frame.origin.x -= homeVC.homeScrollViewOffsetX
                requestView.frame.origin.y = homeVC.selectedView.frame.origin.y + homeVC.selectedBloblFrame.origin.y
                
            }
            )
        {
        
            (finished: Bool) -> Void in
            
                homeVC.selectedView.alpha = 1
                self.finish()
            
        }
        
        // self.finish()
        
    }
    
}
