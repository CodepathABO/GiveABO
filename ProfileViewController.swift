//
//  ProfileViewController.swift
//  GiveABO
//
//  Created by Ramya Baratam on 11/3/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var bloodTypeField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var notificationContainer: UIView!
    @IBOutlet weak var textSwitch: UISwitch!
    
    @IBOutlet weak var payoffView: UIView!
    @IBOutlet weak var payoffLogo: UIButton!
    @IBOutlet weak var payoffThanksText: UILabel!
    @IBOutlet weak var payoffNameText: UILabel!
    @IBOutlet weak var payoffGetStartedText: UILabel!
    @IBOutlet weak var payoffBloodtypeText: UILabel!
    
    
    
    var userFirstName: String!
    var bloodType: String!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var user = PFUser.currentUser()
    
    // Add to Simple
    var account = PFObject(className: "Accounts")

    
  //  @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(user)
        
        firstnameField.text = userFirstName
        firstnameField.alpha = 0
        bloodTypeField.text = bloodType
        bloodTypeField.alpha = 0
        
        payoffNameText.text = userFirstName
        payoffBloodtypeText.text = bloodType
        
        payoffView.frame.origin.x = 0
        payoffView.frame.origin.y = 0
        payoffView.alpha = 0
        payoffLogo.alpha = 0
        payoffThanksText.alpha = 0
        payoffNameText.alpha = 0
        payoffGetStartedText.alpha = 0
        payoffBloodtypeText.alpha = 0
        
        payoffLogo.transform = CGAffineTransformMakeScale(0.8, 0.8)
        payoffThanksText.transform = CGAffineTransformMakeScale(0.8, 0.8)
        payoffNameText.transform = CGAffineTransformMakeScale(0.8, 0.8)
        payoffGetStartedText.transform = CGAffineTransformMakeScale(0.8, 0.8)
        payoffBloodtypeText.transform = CGAffineTransformMakeScale(0.8, 0.8)
        
        finishButton.layer.cornerRadius = 25
        finishButton.layer.borderWidth = 1
        finishButton.backgroundColor = UIColor(red: 255/255, green: 43/255, blue: 58/255, alpha: 1)
        finishButton.layer.borderColor = UIColor.redColor().CGColor
        
        notificationContainer.layer.cornerRadius = 8
        
        
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
        
        
        account["firstname"] = firstnameField.text
        account["lastname"] = lastnameField.text
        account["bloodtype"] = bloodTypeField.text
        account["dob"] = dobField.text
        account["zipcode"] = locationField.text
        account["phone"] = phoneNumberField.text
        
        account["user"] = PFUser.currentUser()?.objectId
        
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
        activityIndicator.center.y = 596
        activityIndicator.center.x = 320
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White
        
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        
        account.saveInBackgroundWithBlock { (success, error) -> Void in
            
            
            if success == true {
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
               
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.payoffView.alpha = 1
                    }, completion: { (Bool) -> Void in
                        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
                            self.payoffLogo.alpha = 1
                            self.payoffLogo.frame.origin.y = 160
                            
                            self.payoffThanksText.alpha = 1
                            self.payoffThanksText.frame.origin.y = 230
                            
                            self.payoffNameText.alpha = 1
                            self.payoffNameText.frame.origin.y = 263
                            
                            self.payoffGetStartedText.alpha = 1
                            self.payoffGetStartedText.frame.origin.y = 304
                            
                            self.payoffBloodtypeText.alpha = 1
                            self.payoffBloodtypeText.frame.origin.y = 334
                            
                            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { () -> Void in
                        
                                self.payoffLogo.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                self.payoffThanksText.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                self.payoffNameText.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                self.payoffGetStartedText.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                self.payoffBloodtypeText.transform = CGAffineTransformMakeScale(1.0, 1.0)
                                }, completion: { (Bool) -> Void in
                                    // ..
                            })
                            
                            }, completion: { (Bool) -> Void in
                                // ..
                                
                                
                        })
                        
                        delay(2.5, closure: { () -> () in
                            
                           // self.goToHome()
                            
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        })

                })
                
                print("Success!")
            } else {
                print("Failed")
                self.activityIndicator.stopAnimating()
                print(error)
            }
        }
        
        // dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func goToHome() {
        
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SBTestViewController") as UIViewController
        
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
