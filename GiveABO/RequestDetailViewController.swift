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
    
    @IBOutlet weak var xButton: UIButton!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var needsLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    var requestContents: [UILabel]!
    
    
    // CONFIRM DETAILS
    
    @IBOutlet weak var confirm_messageView: UIView!
    @IBOutlet weak var confirm_bloodTypeView: UIView!
    @IBOutlet weak var confirm_bloodTypeLabel: UILabel!
    @IBOutlet weak var confirm_phoneView: UIView!
    @IBOutlet weak var confirm_phoneLabel: UILabel!
    @IBOutlet weak var confirm_buttonView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var confirmContents: [UIView]!
    
    
    // SUCCESS MESSAGE
    
    @IBOutlet weak var success_message_1: UIImageView!
    @IBOutlet weak var success_message_2: UIImageView!
    @IBOutlet weak var success_message_3: UIImageView!
    @IBOutlet weak var success_message_4: UIImageView!
    var successContents: [UIImageView]!
    
    @IBOutlet weak var success_ok_button: UIButton!
    
    
    
    var requestView: UIView!
    var initialCenter: CGPoint!
    
    
    var blobImage: UIImage!
    var blobImageView: UIImageView!
    
    
    var nameText = ""
    var messageText = ""
    var bloodTypeText = ""
    
    


    
    
    // PARSE USERS
    var user = PFUser.currentUser()
    var query = PFQuery(className:"Accounts")

    
    // VIEW DID LOAD
    override func viewDidLoad() {
        
        
        // HIDE LOADER
        loader.alpha = 0
        
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
        
        
        // SUCCES CONTENT ARRAY
        successContents = [success_message_1, success_message_2, success_message_3]

        for content in successContents {
            content.alpha = 0
            content.transform = CGAffineTransformMakeTranslation(0, 40)
        }
        
        success_ok_button.alpha = 0
        success_ok_button.transform = CGAffineTransformMakeTranslation(0, 120)
        
        success_message_4.alpha = 0
        success_message_4.transform = CGAffineTransformMakeTranslation(0, 40)

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
    
    
    
    // DID PRESS CONFIRM -----------------------------------------------------------------------------------------------
    
    
    @IBAction func didPressConfirm(sender: UIButton) {
        
//        sender.setTitle("", forState: UIControlState.Selected)
//        sender.selected = !sender.selected
        loader.alpha = 1
        loader.startAnimating()
        xButton.alpha = 0
        
        // FADE OUT CONFIRM CONTENTS
        var confirmDelay = 0.0
        
        for content in self.confirmContents {
            
            UIView.animateWithDuration(
                
                0.8,
                delay: confirmDelay,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    content.alpha = 0
                },
                
                completion: nil
            )
            
            confirmDelay += 0.08
        }
        
        
        // ANIMATE IN SUCCESS CONTENTS
        
        delay(3) { () -> () in
            self.loader.alpha = 0
            
            var successDelay = 0.0
            
            for content in self.successContents {
                
                UIView.animateWithDuration(
                    0.6,
                    delay: 0,
                    usingSpringWithDamping: 0.8,
                    initialSpringVelocity: 0.2,
                    options: UIViewAnimationOptions.CurveEaseInOut,
                    
                    animations: { () -> Void in
                        content.alpha = 1
                        content.transform = CGAffineTransformMakeTranslation(0, 0)
                    }
                )
                {
                    (finished: Bool) -> Void in
                        
                }
                successDelay += 0.4
                
            }
            
            
            // ANIMATE BUTTON
            
            UIView.animateWithDuration(
                0.6,
                delay: 2.0,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
                
                animations: { () -> Void in
                    self.success_message_4.alpha = 1
                    self.success_message_4.transform = CGAffineTransformMakeTranslation(0, 0)
                }
                )
                
                {
                    (finished: Bool) -> Void in
                    
            }
            
            
            // ANIMATE BUTTON
            
            UIView.animateWithDuration(
                0.6,
                delay: 2.4,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
            
                animations: { () -> Void in
                    self.success_ok_button.alpha = 1
                    self.success_ok_button.transform = CGAffineTransformMakeTranslation(0, 0)
                }
            )
            
            {
                (finished: Bool) -> Void in
                
            }
        }
        
        // ANIMATE GREEN BG
        
        self.blobImage = UIImage(named: "blob_green")
        let blobImageView = UIImageView (image: self.blobImage)
        self.requestView.addSubview(blobImageView)
        blobImageView.alpha = 0
        
        UIView.animateWithDuration(
            
            7,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: { () -> Void in
                blobImageView.alpha = 1
            },
            
            completion: nil
        )
        
        jeremieDonated = true
        print("in request detail \(jeremieDonated)")
        
        
        
    }
    
    @IBAction func didPressX(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func didPressSuccessOK(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // GO TO SIGNUP STORYBOARD -----------------------------------------------------------------------------------------
    
    
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
