//
//  OnboardViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 10/31/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class OnboardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var introContentOneView: UIView!
    @IBOutlet weak var introContentTwoView: UIView!
    @IBOutlet weak var introContentThreeView: UIView!
    @IBOutlet weak var introContentFourView: UIView!
    
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    
    var btnOriginYPos: CGFloat!
    
    var scale = CGFloat(1.0)
    var rotation = CGFloat(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1500, height: 667)
        
        introContentOneView.layer.cornerRadius = introContentOneView.frame.size.width / 2
        
        introContentOneView.alpha = 0
        introContentOneView.center.y = 800
        
        introContentOneView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        introContentOneView.transform = CGAffineTransformMakeRotation(CGFloat(60 * M_PI / 180))
        
        introContentTwoView.layer.cornerRadius = introContentTwoView.frame.size.width / 2
        
        introContentThreeView.layer.cornerRadius = introContentThreeView.frame.size.width / 2
        
        introContentFourView.layer.cornerRadius = introContentFourView.frame.size.width / 2
        
        introContentTwoView.center.y = 280
        introContentTwoView.transform = CGAffineTransformMakeRotation(CGFloat(60 * M_PI / 180))
        introContentTwoView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        introContentThreeView.center.y = 280
        introContentThreeView.transform = CGAffineTransformMakeRotation(CGFloat(60 * M_PI / 180))
        introContentThreeView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        introContentFourView.center.y = 280
        introContentFourView.transform = CGAffineTransformMakeRotation(CGFloat(60 * M_PI / 180))
        introContentFourView.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        btnOriginYPos = CGFloat(800)
        
        getStartedButton.layer.cornerRadius = 25
        
        getStartedButton.center.y = btnOriginYPos
        
        getStartedButton.transform = CGAffineTransformMakeRotation(CGFloat(20 * M_PI / 180))
        
        pageControl.alpha = 0
        
        for i in 0...18 {
            
            let platelet = UIView()
            platelet.frame = CGRect(x: 55, y: 300, width: 100, height: 100)
            platelet.backgroundColor = UIColor(red:0.59, green:0.14, blue:0.14, alpha:1.0)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.7) { () -> Void in
            self.introContentOneView.alpha = 1
        }
        
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            self.introContentOneView.center.y = 280
            self.introContentOneView.transform = CGAffineTransformMakeScale(1, 1)
            self.introContentOneView.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
            
            }, completion: { (Bool) -> Void in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.pageControl.alpha = 1
                })
        })
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
    
    // MARK: ACTIONS
    
    
    @IBAction func signInButtonDidTouch(sender: UIButton) {
        
        performSegueWithIdentifier("signInSegue", sender: self)
        
    }

    
    
    // MARK: SCROLLVIEW CONTROL
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.x
        
        let finalOffset = scrollView.contentSize.width - scrollView.frame.width
        
        print("Current Offset \(currentOffset) Final Offset \(finalOffset)")
        
        
        
        if currentOffset < 0 {
            
            let introOneX = convertValue(currentOffset, r1Min: 0, r1Max: -375, r2Min: 0, r2Max: 0)
            let introOneY = convertValue(currentOffset, r1Min: 0, r1Max: -375, r2Min: 0, r2Max: 70)
            
            let scale = convertValue(currentOffset, r1Min: 0, r1Max: -375, r2Min: 1, r2Max: 0.8)
            
            let rotation = convertValue(currentOffset, r1Min: 0, r1Max: -375, r2Min: 0, r2Max: 60)
            
            let bubbleAlpha = convertValue(currentOffset, r1Min: 0, r1Max: -375, r2Min: 1, r2Max: 0)
            
            introContentOneView.transform = CGAffineTransformMakeTranslation(introOneX, introOneY)
            introContentOneView.transform = CGAffineTransformScale(introContentOneView.transform, CGFloat(scale), CGFloat(scale))
            introContentOneView.transform = CGAffineTransformRotate(introContentOneView.transform, CGFloat(Double(rotation) * M_PI / 180))
            introContentOneView.alpha = bubbleAlpha
        }
        
        
        if currentOffset > 0 && currentOffset < 375 {
            
            let introOneX = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: 0)
            let introOneY = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: 70)
            
            let scale = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 1, r2Max: 0.8)
            
            let rotation = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: -60)
            
            let bubbleAlpha = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 1, r2Max: 0)
            
            introContentOneView.transform = CGAffineTransformMakeTranslation(introOneX, introOneY)
            introContentOneView.transform = CGAffineTransformScale(introContentOneView.transform, CGFloat(scale), CGFloat(scale))
            introContentOneView.transform = CGAffineTransformRotate(introContentOneView.transform, CGFloat(Double(rotation) * M_PI / 180))
            introContentOneView.alpha = bubbleAlpha
            signInButton.alpha = bubbleAlpha
            
            
            let introTwoX = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: 0)
            let introTwoY = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 70, r2Max: 0)
            
            let scale2 = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0.8, r2Max: 1)
            
            let rotation2 = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 60, r2Max: 0)
            
            let bubbleAlpha2 = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: 1)
            
            introContentTwoView.transform = CGAffineTransformMakeTranslation(introTwoX, introTwoY)
            introContentTwoView.transform = CGAffineTransformScale(introContentTwoView.transform, CGFloat(scale2), CGFloat(scale2))
            introContentTwoView.transform = CGAffineTransformRotate(introContentTwoView.transform, CGFloat(Double(rotation2) * M_PI / 180))
            introContentTwoView.alpha = bubbleAlpha2
            
        }
        
        if currentOffset > 375 && currentOffset < 750 {
            
            
            let introTwoX = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 0, r2Max: 0)
            let introTwoY = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 0, r2Max: 70)
            
            let scale2 = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 1, r2Max: 0.8)
            
            let rotation2 = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 0, r2Max: -60)
            
            let bubbleAlpha2 = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 1, r2Max: 0)
            
            introContentTwoView.transform = CGAffineTransformMakeTranslation(introTwoX, introTwoY)
            introContentTwoView.transform = CGAffineTransformScale(introContentTwoView.transform, CGFloat(scale2), CGFloat(scale2))
            introContentTwoView.transform = CGAffineTransformRotate(introContentTwoView.transform, CGFloat(Double(rotation2) * M_PI / 180))
            introContentTwoView.alpha = bubbleAlpha2
            
            let introThreeX = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 0, r2Max: 0)
            let introThreeY = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 70, r2Max: 0)
            
            let scale3 = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 0.8, r2Max: 1)
            
            let rotation3 = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 60, r2Max: 0)
            
            let bubbleAlpha3 = convertValue(currentOffset, r1Min: 375, r1Max: 750, r2Min: 0, r2Max: 1)
            
            introContentThreeView.transform = CGAffineTransformMakeTranslation(introThreeX, introThreeY)
            introContentThreeView.transform = CGAffineTransformScale(introContentThreeView.transform, CGFloat(scale3), CGFloat(scale3))
            introContentThreeView.transform = CGAffineTransformRotate(introContentThreeView.transform, CGFloat(Double(rotation3) * M_PI / 180))
            introContentThreeView.alpha = bubbleAlpha3
        }
        
        
        if currentOffset > 750 && currentOffset < 1125 {
            
            
            let introThreeX = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 0, r2Max: 0)
            let introThreeY = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 0, r2Max: 70)
            
            let scale3 = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 1, r2Max: 0.8)
            
            let rotation3 = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 0, r2Max: -60)
            
            let bubbleAlpha3 = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 1, r2Max: 0)
            
            introContentThreeView.transform = CGAffineTransformMakeTranslation(introThreeX, introThreeY)
            introContentThreeView.transform = CGAffineTransformScale(introContentThreeView.transform, CGFloat(scale3), CGFloat(scale3))
            introContentThreeView.transform = CGAffineTransformRotate(introContentThreeView.transform, CGFloat(Double(rotation3) * M_PI / 180))
            introContentThreeView.alpha = bubbleAlpha3
            pageControl.alpha = bubbleAlpha3
            skipButton.alpha = bubbleAlpha3
            
            let introFourX = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 0, r2Max: 0)
            let introFourY = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 70, r2Max: 0)
            
            let scale4 = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 0.8, r2Max: 1)
            
            let rotation4 = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 60, r2Max: 0)
            
            let bubbleAlpha4 = convertValue(currentOffset, r1Min: 750, r1Max: 1125, r2Min: 0, r2Max: 1)
            
            introContentFourView.transform = CGAffineTransformMakeTranslation(introFourX, introFourY)
            introContentFourView.transform = CGAffineTransformScale(introContentFourView.transform, CGFloat(scale4), CGFloat(scale4))
            introContentFourView.transform = CGAffineTransformRotate(introContentFourView.transform, CGFloat(Double(rotation4) * M_PI / 180))
            introContentFourView.alpha = bubbleAlpha4
            getStartedButton.alpha = bubbleAlpha4
        }
        
        if currentOffset > 1125 {
            
            
            let introFourX = convertValue(currentOffset, r1Min: 1125, r1Max: 1500, r2Min: 0, r2Max: 0)
            let introFourY = convertValue(currentOffset, r1Min: 1125, r1Max: 1500, r2Min: 0, r2Max: 70)
            
            let scale4 = convertValue(currentOffset, r1Min: 1125, r1Max: 1500, r2Min: 1, r2Max: 0.8)
            
            let rotation4 = convertValue(currentOffset, r1Min: 1125, r1Max: 1500, r2Min: 0, r2Max: -60)
            
            let bubbleAlpha4 = convertValue(currentOffset, r1Min: 1125, r1Max: 1500, r2Min: 1, r2Max: 0)
            
            introContentFourView.transform = CGAffineTransformMakeTranslation(introFourX, introFourY)
            introContentFourView.transform = CGAffineTransformScale(introContentFourView.transform, CGFloat(scale4), CGFloat(scale4))
            introContentFourView.transform = CGAffineTransformRotate(introContentFourView.transform, CGFloat(Double(rotation4) * M_PI / 180))
            introContentFourView.alpha = bubbleAlpha4
            getStartedButton.alpha = bubbleAlpha4
        }
        
        
        
        
        
        if scrollView == finalOffset {
            //            pageControl.alpha = 0
            //            self.skipButton.alpha = 0
        }
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let page : Int = Int(round(scrollView.contentOffset.x / 375))
        
        pageControl.currentPage = page
        
        
        
        if pageControl.currentPage == 0 {
            
        }
        
        if pageControl.currentPage == 3 {
            
            UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.6, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                self.getStartedButton.center.y = 530
                self.getStartedButton.transform = CGAffineTransformMakeRotation(CGFloat(0 * M_PI / 180))
                }, completion: { (Bool) -> Void in
                    // ..
            })
            
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.pageControl.alpha = 1
                self.skipButton.alpha = 1
                self.getStartedButton.center.y = self.btnOriginYPos
                self.getStartedButton.transform = CGAffineTransformMakeRotation(CGFloat(20 * M_PI / 180))
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
