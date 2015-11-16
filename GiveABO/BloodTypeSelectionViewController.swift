//
//  BloodTypeSelectionViewController.swift
//  GiveABO-3
//
//  Created by Sebastian Drew on 11/15/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class BloodTypeSelectionViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var posNegContain: UIView!
    @IBOutlet weak var positiveButton: UIButton!
    @IBOutlet weak var negativeButton: UIButton!
    @IBOutlet weak var posNegLabel: UILabel!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var splitOne: UIView!
    @IBOutlet weak var splitTwo: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var firstName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // let defaults = NSUserDefaults.standardUserDefaults()
        // let firstName = defaults.objectForKey("first_name") as! String
        
        messageLabel.text = firstName
        messageLabel.textColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        
        segmentedControl.selectedSegmentIndex = 0

        confirmButton.enabled = false
        confirmButton.layer.cornerRadius = 25
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dismissButton.alpha = 0
        posNegLabel.frame.origin.x = 230
        
        bloodTypeLabel.alpha = 0
        bloodTypeLabel.transform = CGAffineTransformMakeScale(0.8, 0.8)
        bloodTypeLabel.frame.origin.y = 300
        
        orLabel.alpha = 0
        orLabel.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        orLabel.alpha = 0
        orLabel.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        orLabel.alpha = 0
        orLabel.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        positiveButton.alpha = 0
        positiveButton.frame.origin.x = 44
        positiveButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
        negativeButton.alpha = 0
        negativeButton.frame.origin.x = 174
        negativeButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
        confirmButton.alpha = 0
        confirmButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.bloodTypeLabel.alpha = 1
            self.bloodTypeLabel.transform = CGAffineTransformMakeScale(1, 1)
            self.bloodTypeLabel.frame.origin.y = 230
            
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.4, delay: 0.4, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
                    
                    self.splitOne.alpha = 1
                    self.splitTwo.alpha = 1
                    self.splitOne.frame.origin.y = 15
                    self.splitTwo.frame.origin.y = 84
                    
                    
                    }, completion: { (Bool) -> Void in
                        
                        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
                            self.orLabel.transform = CGAffineTransformMakeScale(1, 1)
                            self.orLabel.alpha = 1
                            self.positiveButton.alpha = 1
                            self.positiveButton.frame.origin.x = 34
                            self.positiveButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
                            self.negativeButton.alpha = 1
                            self.negativeButton.frame.origin.x = 184
                            self.negativeButton.transform = CGAffineTransformMakeScale(0.8, 0.8)
                            
                            }, completion: { (Bool) -> Void in
                                // ..
                        })
                        
                })
                
        }
        
    }
    
    @IBAction func onTypeSelection(sender: UISegmentedControl) {
    
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            
            bloodTypeLabel.text = "A"
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
                self.posNegLabel.frame.origin.x = 230
            self.bloodTypeLabel.frame.origin.x = 57
                }, completion: { (Bool) -> Void in
                    // ..
            })
            
        case 1:
            
            bloodTypeLabel.text = "B"
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
                self.posNegLabel.frame.origin.x = 230
                self.bloodTypeLabel.frame.origin.x = 57
                }, completion: { (Bool) -> Void in
                    // ..
            })
            
            
        case 2:
            
            bloodTypeLabel.text = "AB"
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
                self.posNegLabel.frame.origin.x = 260
                self.bloodTypeLabel.frame.origin.x = 37
                }, completion: { (Bool) -> Void in
                    // ..
            })
            
            
        case 3:
            
            bloodTypeLabel.text = "O"
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
                self.posNegLabel.frame.origin.x = 240
                self.bloodTypeLabel.frame.origin.x = 57
                }, completion: { (Bool) -> Void in
                    // ..
            })
            
        default: break
            
        }
        
    }
    
    @IBAction func positiveButtonDidTouch(sender: UIButton) {
        
        posNegLabel.text = "+"
        
        confirmButtonShow()
        
    }
    
    @IBAction func negativeButtonDidTouch(sender: UIButton) {
        
        posNegLabel.text = "-"
        
        confirmButtonShow()
    }
    
    
    @IBAction func closeButtonDidTouch(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func backButtonDidTouch(sender: UIButton) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func confirmButtonDidTouch(sender: UIButton) {
        
        performSegueWithIdentifier("toProfileSegue", sender: self)
        
        
    }
    
    func confirmButtonShow() {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .CurveEaseIn, animations: { () -> Void in
            self.confirmButton.enabled = true
            self.confirmButton.alpha = 1
            self.confirmButton.transform = CGAffineTransformMakeScale(1, 1)
            }, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toProfileSegue" {
            
            let profileViewController = segue.destinationViewController as! ProfileViewController
            
            profileViewController.bloodType = bloodTypeLabel.text! + posNegLabel.text!
            
            profileViewController.userFirstName = messageLabel.text!
            
            
        }
    }

}
