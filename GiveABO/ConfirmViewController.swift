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
    
    @IBOutlet weak var typeImage: UIImageView!
    
    @IBOutlet weak var signLabel: UILabel!
    
    
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
        confirmButton.backgroundColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        confirmButton.layer.borderColor = UIColor.redColor().CGColor

        let defaults = NSUserDefaults.standardUserDefaults()
        let firstName = defaults.objectForKey("first_name") as! String
        let sign = defaults.objectForKey("sign") as! Int
        
        messageLabel.text = "\(firstName),"
        messageLabel.textColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        
        
        bloodType = defaults.objectForKey("index") as! Int
        
        bloodDetailImage.image = arrayOfImages[bloodType]
        
        if (sign == 1){
            
           signLabel.text = "-"
        }
        else{
            signLabel.text = "+"
        }
        
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
