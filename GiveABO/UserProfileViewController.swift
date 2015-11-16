//
//  UserProfileViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit
import Parse

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = ["Blood bank: Cal Pacific Blood bank", "Direct Request", "Direct Request", "Blood bank: SF General", "Blood drive: American Red Cross"]
    
    var user = PFUser.currentUser()
    var query = PFQuery(className:"Accounts")

    @IBOutlet weak var totalDonationsView: UIView!
    @IBOutlet weak var yearlyDonationsView: UIView!
    @IBOutlet weak var donationStreakView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableTitleView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var userDataView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bloodTypeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false

        tableView.delegate = self
        tableView.dataSource = self
        
        // PARSE USER INFO
        
        query.whereKey("user", equalTo: (user?.objectId)!)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if let objects = objects {
                
                for object in objects {
                    
                    var firstname = object["firstname"] as! String
                    var lastname = object["lastname"] as! String
                    var bloodtype = object["bloodtype"] as! String
                    
                    // print(firstname)
                    
                    self.nameLabel.text = firstname + " " + lastname
                    self.bloodTypeLabel.text = bloodtype
                    
                    
                    
                }
            }

        }
        
        donationStreakView.layer.cornerRadius = donationStreakView.frame.size.width / 2
        
        donationStreakView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        donationStreakView.layer.borderWidth = 8
        
        yearlyDonationsView.layer.cornerRadius = yearlyDonationsView.frame.size.width / 2
        
        yearlyDonationsView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        yearlyDonationsView.layer.borderWidth = 8
        
        totalDonationsView.layer.cornerRadius = totalDonationsView.frame.size.width / 2
        
        totalDonationsView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        totalDonationsView.layer.borderWidth = 8
        
        tableView.alpha = 0
        tableTitleView.alpha = 0
        statsView.alpha = 0
        userDataView.alpha = 0
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
            
            UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
                self.userDataView.alpha = 1
                self.statsView.alpha = 1
                self.tableTitleView.alpha = 1
                self.tableView.alpha = 1
                }) { (Bool) -> Void in
 
            }
        }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.userDataView.alpha = 0
            self.statsView.alpha = 0
            self.tableTitleView.alpha = 0
            self.tableView.alpha = 0
            }) { (Bool) -> Void in
                
        }
    }
    
    
    // MAEK: ACTIONS
    
    @IBAction func closeButton(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = data[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.accessoryType = .Checkmark
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       
        
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
