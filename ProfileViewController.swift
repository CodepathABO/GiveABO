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
    
    @IBOutlet weak var lastnameField: UITextField!
    
    @IBOutlet weak var dobField: UITextField!
    
    @IBOutlet weak var locationField: UITextField!
    
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
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

    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = NSDateFormatter()
        
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        dobField.text = dateFormatter.stringFromDate(sender.date)
        
    }

    
    @IBAction func dobEditing(sender: UITextField) {

    
    var datePickerView:UIDatePicker = UIDatePicker()
    datePickerView.datePickerMode = UIDatePickerMode.Date
    sender.inputView = datePickerView
    datePickerView.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
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
