//
//  BloodDetailsViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class BloodDetailsViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var bloodDetailImage: UIImageView!
    var bloodType: Int = 0
    var arrayOfImages: [UIImage]!
    
    var sign: Int!
    
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
        
        messageLabel.text = "\(firstName)..."
        messageLabel.textColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        
        continueButton.layer.cornerRadius = 25
        continueButton.layer.borderWidth = 1
        continueButton.backgroundColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
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

    @IBAction func onBack(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func onTypePressed(sender: UIButton) {
        
        //print("\(sender.tag)")
        
        sign = sender.tag
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(sign, forKey: "sign")
        defaults.synchronize()
        
        
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
