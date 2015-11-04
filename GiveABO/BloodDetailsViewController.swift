//
//  BloodDetailsViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class BloodDetailsViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let firstName = defaults.objectForKey("first_name") as! String
        
        messageLabel.text = "Great! \(firstName),"
        
        continueButton.layer.cornerRadius = 25
        continueButton.layer.borderWidth = 1
        continueButton.layer.backgroundColor =
            UIColor.redColor().CGColor
        continueButton.layer.borderColor = UIColor.redColor().CGColor
        
        bloodType = defaults.objectForKey("index") as! Int
        //arrayOfImages = defaults.objectForKey("array_of_images") as! [UIImage]
        
        bloodDetailImage.image = arrayOfImages[bloodType]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onContinue(sender: AnyObject) {
        
        self.performSegueWithIdentifier("DetailsToConfirm", sender: nil)
        
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
