//
//  BloodTypeViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class BloodTypeViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var bloodTypeImage: UIImageView!
    @IBOutlet weak var segControl: UISegmentedControl!
    
    var arrayOfImages: [UIImage]!
    
    var index: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfImages = [
            UIImage(named: "typeA")!,
            UIImage(named: "typeB")!,
            UIImage(named: "typeAB")!,
            UIImage(named: "typeO")!,
        ]
        
        bloodTypeImage.image = UIImage(named: "typeA")
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let firstName = defaults.objectForKey("first_name") as! String
        
        messageLabel.text = "Okay \(firstName),"
        
        continueButton.layer.cornerRadius = 25
        continueButton.layer.borderWidth = 1
        continueButton.layer.backgroundColor =
            UIColor.redColor().CGColor
        continueButton.layer.borderColor = UIColor.redColor().CGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        index = segControl.selectedSegmentIndex
        
            bloodTypeImage.image = arrayOfImages[index]
        }
    
    @IBAction func onContinue(sender: AnyObject) {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(index, forKey: "index")
        defaults.synchronize()
        
        self.performSegueWithIdentifier("TypeToDetails", sender: nil)
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
