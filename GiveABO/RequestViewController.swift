//
//  RequestViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/4/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class RequestViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var timeLimitField: UITextField!
    @IBOutlet weak var bloodTypeNeededField: UITextField!
    @IBOutlet weak var requestDescriptionText: UITextView!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var request = PFObject(className: "Request")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    @IBAction func submitRequestDidTouch(sender: UIButton) {
        
        request["name"] = nameField.text
        request["timelimit"] = timeLimitField.text
        request["bloodtype"] = bloodTypeNeededField.text
        request["description"] = requestDescriptionText.text
        
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center.y = 100
        activityIndicator.center.x = self.view.center.x
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        
        request.saveInBackgroundWithBlock { (success, error) -> Void in
            
            
            if success == true {
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                self.performSegueWithIdentifier("successSegue", sender: self)
                print("Success!")
            } else {
                print("Failed")
                self.activityIndicator.stopAnimating()
                print(error)
            }
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
