//
//  RequestDetailViewController.swift
//  GiveABO
//
//  Created by Sybico, Christopher on 10/30/15.
//  Copyright © 2015 Sybico, Christopher. All rights reserved.
//

import UIKit
import Parse

class RequestDetailViewController: UIViewController {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var needsLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    
    
    // CONFIRM DETAILS


    @IBOutlet weak var confirm_messageView: UIView!
    @IBOutlet weak var confirm_bloodTypeView: UIView!
    @IBOutlet weak var confirm_bloodTypeLabel: UILabel!
    @IBOutlet weak var confirm_phoneView: UIView!
    @IBOutlet weak var confirm_phoneLabel: UILabel!
    
    @IBOutlet weak var confirm_buttonView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    var requestView: UIView!
    var initialCenter: CGPoint!
    
    
    var blobImage: UIImage!
    var blobImageView: UIImageView!
    
    
    var nameText = ""
    var messageText = ""
    var bloodTypeText = ""
    
    
    var requestContents: [UILabel]!
    var confirmContents: [UIView]!
    
    
    // PARSE USERS
    var user = PFUser.currentUser()
    var query = PFQuery(className:"Accounts")

    
    // VIEW DID LOAD
    override func viewDidLoad() {
        
        
        // HIDE STATUS BAR
        UIApplication.sharedApplication().statusBarHidden = true
        
        super.viewDidLoad()

        requestView = UIView()
        
        // REQUEST CONTENT ARRAY
        requestContents = [nameLabel, dateLabel, messageLabel, needsLabel, bloodTypeLabel]
        
        for content in requestContents {
            content.alpha = 0
        }
        
        nameLabel.text = nameText
        messageLabel.text = messageText
        bloodTypeLabel.text = bloodTypeText
        
        let requestViewPan = UIPanGestureRecognizer(target: self, action: "didPanRequest:")
        requestView.addGestureRecognizer(requestViewPan)
        
        // SETUP DONATE BUTTON
        donateButton.alpha = 0
        
        
        
        // CONFIRM CONTENT ARRAY
        confirmContents = [confirm_messageView, confirm_bloodTypeView, confirm_phoneView, confirm_buttonView]
        
        for content in confirmContents {
            content.alpha = 0
            content.frame.origin.x += 300
        }
    }
    
    
    // VIEW DID APPEAR
    override func viewDidAppear(animated: Bool) {

        
        // ANIMATE REQUEST CONTENTS
        var delay = 0.0
        
        for content in requestContents {
            
            UIView.animateWithDuration(
                0.4,
                delay: delay,
                options: UIViewAnimationOptions.CurveEaseIn,
                animations: { () -> Void in
                    content.alpha = 1
                },
                completion: nil
            )
            delay += 0.08
        }
        
        // ANIMATE BUTTON
        UIView.animateWithDuration(
            0.2,
            delay: 0.4,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.donateButton.alpha = 1
            },
            completion: nil
        )
        
        
        
        // CHECK IF USER CAME FROM CREATE ACCOUNT
        if fromCreateAccount == true {
            
            var user = PFUser.currentUser()
            
            if user != nil  {
                
                print("Request Detail logged in ")
                hideRequestContent()
                showConfirmContent()
                fromCreateAccount = false
            }
        }
    }
    
    
    // HIDE REQUEST CONTENT
    func hideRequestContent(){
        
        // ANIMATE REQUEST CONTENTS
        
        for content in requestContents {
            
            UIView.animateWithDuration(
                
                0.4,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0.1,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    content.alpha = 0
                },
                
                completion: nil
            )
        }
        
        // ANIMATE BUTTON
        UIView.animateWithDuration(
            0.2,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                self.donateButton.alpha = 0
            },
            completion: nil
        )

    
    }
    
    // SHOW CONFIRM CONTENTS
    func showConfirmContent() {
        
        
        // PARSE
        var user = PFUser.currentUser()
        var query = PFQuery(className:"Accounts")
        
        // PARSE USER INFO
        query.whereKey("user", equalTo: (user?.objectId)!)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                
                for object in objects {
                    
                    var firstname = object["firstname"] as! String
                    var lastname = object["lastname"] as! String
                    var bloodtype = object["bloodtype"] as! String
                    var phonenumber = object["phone"] as! String
                    
                    // print(firstname)
                    
                    self.confirm_bloodTypeLabel.text = bloodtype
                    self.confirm_phoneLabel.text = phonenumber
                    
                }
            }
        }
        
        
        // ANIMATE CONFIRM CONTENTS
        var delay = 0.0
        
        for content in confirmContents {
            
            UIView.animateWithDuration(
                
                0.8,
                delay: delay,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    content.alpha = 1
                    content.frame.origin.x = 38
                },
                
                completion: nil
            )
            
            delay += 0.08
        }
    }
    
    // ON PRESS DONATE
    @IBAction func didPressDonate(sender: AnyObject) {
        
        // CHECK IF USER IS LOGGED IN
        var user = PFUser.currentUser()
        
        if user != nil  {
            hideRequestContent()
            showConfirmContent()
        }
            
        else {
            goToSignup()
        }
        
    }
    
    @IBAction func didPressConfirm(sender: AnyObject) {
        
    }
    
    @IBAction func didPressX(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // GO TO SIGNUP STORYBOARD
    func goToSignup() {
        
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpNavigationViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }

    // PAN ON REQUEST
    func didPanRequest(sender: UIPanGestureRecognizer) {
    
        let translation = sender.translationInView(view)
    
    
        // BEGIN PANNING
        if sender.state == UIGestureRecognizerState.Began {
        
            initialCenter = requestView.center
        
        }
        
        // PANNING
        else if sender.state == UIGestureRecognizerState.Changed {
            print("panning")
        
            requestView.center.y = initialCenter.y + translation.y
        
        }
        
        // END PANNING
        else if sender.state == UIGestureRecognizerState.Ended {
            dismissViewControllerAnimated(true, completion: nil)
        }
    
    }
}
