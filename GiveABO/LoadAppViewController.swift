//
//  LoadAppViewController.swift
//  GiveABO-3
//
//  Created by Sebastian Drew on 11/15/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class LoadAppViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIApplication.sharedApplication().statusBarHidden = true
        
        var user = PFUser.currentUser()
        
        if user != nil  {
            goToHome()
            print(user)
            
        }
            
        else {
            performSegueWithIdentifier("onBoardSegue", sender: self)
        }
 
        
    }


    func goToHome() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SBTestViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
}
