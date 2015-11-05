//
//  UserAccountViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserAccountViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var screenOriginalCenter: CGPoint!
    
    var screenUp: CGPoint!
    var screenDown: CGPoint!
    
    var friction: CGFloat!

    let data = ["Blood bank: Cal Pacific Blood bank", "Direct Request", "Direct Request", "Blood bank: SF General", "Blood drive: American Red Cross"]

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuScrollView: UIScrollView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var totalDonationsView: UIView!
    @IBOutlet weak var yearlyDonationsView: UIView!
    @IBOutlet weak var dontationStreakView: UIView!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        menuScrollView.alpha = 1
        // settingsScrollView.alpha = 0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        screenUp = CGPoint(x: 0, y: 20)
        screenDown = CGPoint(x: 0, y: 580)
        
        contentView.frame.origin = screenUp
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSizeMake(0, -2)
        contentView.layer.shadowRadius = 2
        
        donateButton.layer.cornerRadius = 16
        donateButton.layer.borderColor = UIColor(red:0.25, green:0.32, blue:0.38, alpha:0.4).CGColor
        donateButton.layer.borderWidth = 1
        
        requestButton.layer.cornerRadius = 16
        requestButton.layer.borderColor = UIColor(red:0.25, green:0.32, blue:0.38, alpha:0.4).CGColor
        requestButton.layer.borderWidth = 1
        
        dontationStreakView.layer.cornerRadius = dontationStreakView.frame.size.width / 2
        
        dontationStreakView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        dontationStreakView.layer.borderWidth = 8
        
        yearlyDonationsView.layer.cornerRadius = yearlyDonationsView.frame.size.width / 2
        
        yearlyDonationsView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        yearlyDonationsView.layer.borderWidth = 8
        
        totalDonationsView.layer.cornerRadius = totalDonationsView.frame.size.width / 2
        
        totalDonationsView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        totalDonationsView.layer.borderWidth = 8
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = data[indexPath.row]
        cell.accessoryType = .Checkmark
        
        return cell
        
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
