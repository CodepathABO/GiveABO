//
//  CreateRequestViewController.swift
//  GiveABO
//
//  Created by Sybico, Christopher on 11/4/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class CreateRequestViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBloodTypeLabel: UILabel!
    
    var user = PFUser.currentUser()
    var query = PFQuery(className:"Simple")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Run the query on user data and perform logged in user interactions
        print ("youre logged in")
        
        // HIDE STATUSBAR
        UIApplication.sharedApplication().statusBarHidden = false
        
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
        
    }

    override func didReceiveMemoryWarning() {

        super.didReceiveMemoryWarning()

    }
    
    // DISMISS CREATE REQUEST SCREEN
    @IBAction func didPressPost(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
