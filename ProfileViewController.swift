//
//  ProfileViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishButton.layer.cornerRadius = 25
        finishButton.layer.borderWidth = 1
        finishButton.layer.backgroundColor =
            UIColor.redColor().CGColor
        finishButton.layer.borderColor = UIColor.redColor().CGColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
