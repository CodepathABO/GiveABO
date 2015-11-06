//
//  CreateRequestViewController.swift
//  GiveABO
//
//  Created by Sybico, Christopher on 11/4/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class CreateRequestViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBloodTypeLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    var user = PFUser.currentUser()
    var query = PFQuery(className:"Simple")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // HIDE STATUSBAR
        UIApplication.sharedApplication().statusBarHidden = true
        
        
        // PARSE USER INFO
        query.whereKey("user", equalTo: (user?.objectId)!)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                
                for object in objects {
                    
                    var firstname = object["firstname"] as! String
                    var lastname = object["lastname"] as! String
                    var bloodtype = object["bloodtype"] as! String
                    
                    // print(firstname)
                    
                    self.userNameLabel.text = firstname + " " + lastname
                    self.userBloodTypeLabel.text = bloodtype
                    
                    
                    
                }
            }
        }
        
        
        // SET UP TEXT VIEW
        
        messageTextView.text = "Write your message"
        messageTextView.alpha = 0.6
        
        messageTextView.delegate = self
//        messageTextView.becomeFirstResponder()
        
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "Write your message" {
            textView.text = nil
            textView.alpha = 1
        }
    }

    
    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }
    
    @IBAction func didPressClose(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        newRequestListener = false
    }
    
    // DISMISS CREATE REQUEST SCREEN
    @IBAction func didPressPost(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        newRequestName = userNameLabel.text!
        newRequestBloodType = userBloodTypeLabel.text!
        newRequestMessage = messageTextView.text
        newRequestListener = true
    }
    
    
    
    

}
