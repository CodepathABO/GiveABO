//
//  SBTestViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/1/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class SBTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func accountButtonDidTouch(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
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
