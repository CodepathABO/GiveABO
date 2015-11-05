//
//  ConfirmViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var bloodDetailImage: UIImageView!
    
    var bloodType: Int = 0
    var arrayOfImages: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfImages = [
            UIImage(named: "typeA")!,
            UIImage(named: "typeB")!,
            UIImage(named: "typeAB")!,
            UIImage(named: "typeO")!,
        ]
        
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderWidth = 1
        confirmButton.layer.backgroundColor =
            UIColor.redColor().CGColor
        confirmButton.layer.borderColor = UIColor.redColor().CGColor

        let defaults = NSUserDefaults.standardUserDefaults()
        let firstName = defaults.objectForKey("first_name") as! String
        
        messageLabel.text = "Great! \(firstName),"
        
        
        bloodType = defaults.objectForKey("index") as! Int
        
         bloodDetailImage.image = arrayOfImages[bloodType]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
        
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
