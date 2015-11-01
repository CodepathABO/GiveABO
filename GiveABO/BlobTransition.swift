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
        //let requestView = UIView(frame: homeVC.selectedViewOriginalFrame)
        requestView.frame = homeVC.selectedViewOriginalFrame
        
        // ADD SCROLL OFFSET FROM HOME
        requestView.frame.origin.x -= homeVC.homeScrollViewOffsetX

        // DISPLAY REQUEST IN DETAIL VIEW
        requestDetialVC.view.addSubview(requestView)
        
        // SETUP BLOB IMAGE VIEW
        let blobImageView = UIImageView (image: requestDetialVC.blobImage)
        requestView.addSubview(blobImageView)
        
        // HIDE SELECTED VIEW IN HOME
        homeVC.selectedView.alpha = 0
        
        // ANIMATE
        UIView.animateWithDuration(
            
            duration,
            delay: 0,
            usingSpringWithDamping: 2,
            initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                requestView.center = CGPoint(x: 180, y: 333)
                
                requestView.transform = CGAffineTransformMakeScale(3, 3)
                
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
        
        // GET X & Y POSITION OF SELECTED BLOB IN HOME
        let currentX = homeVC.selectedView.center.x - homeVC.homeScrollViewOffsetX
        let currentY = homeVC.selectedView.center.y
        
        // ANIMATE
        UIView.animateWithDuration(
            
            duration,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.1,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                
                requestView.center = CGPoint(
                    x: currentX,
                    y: currentY
                )
                
                requestView.transform = CGAffineTransformMakeScale(1, 1)
                
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
