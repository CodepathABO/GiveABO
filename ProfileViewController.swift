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
    
    @IBOutlet weak var notificationContainer: UIView!
    
  //  @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishButton.layer.cornerRadius = 25
        finishButton.layer.borderWidth = 1
        finishButton.backgroundColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        finishButton.layer.borderColor = UIColor.redColor().CGColor
        
        notificationContainer.layer.cornerRadius = 8
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
    
    @IBAction func onPhoneEditFinished(sender: AnyObject) {
        
       // formatAsPhoneNumber()
    }
    /*
    func formatAsPhoneNumber() -> String {
        let len = count(self)
        var pattern: String
        var replacement: String
        switch len {
        case 11:
            pattern = "(\\d)(\\d{3})(\\d{3})(\\d{4})"
            replacement = "$1 ($2) $3-$4"
        case 10:
            pattern = "(\\d{3})(\\d{3})(\\d{4})"
            replacement = "($1) $2-$3"
        default:
            return self
        }
        
        let nsText = self as NSString
        return nsText.stringByReplacingOccurrencesOfString(pattern, withString: replacement, options: .RegularExpressionSearch, range: NSMakeRange(0, len))
    }
*/

    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    @IBAction func onBack(sender: AnyObject) {
        
        navigationController?.popViewControllerAnimated(true)

    }
    
    @IBAction func onFinish(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    
    func goToHome() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SBTestViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
