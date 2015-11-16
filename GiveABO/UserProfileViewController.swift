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
    
    var objects = [
        ["name" : "Group A","desc": "Has only the A antigen on red cells (and B antibody in the plasma)", "type": "A"],
        ["name" : "Group B","desc": "Has only the B antigen on red cells (and A antibody in the plasma)", "type": "B"],
        ["name" : "Group AB","desc": "Has both A and B antigens on red cells (but neither A nor B antibody in the plasma)", "type": "AB"],
        ["name" : "Group O","desc": "Has neither A nor B antigens on red cells (but both A and B antibody are in the plasma)", "type": "O"]]
    
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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lastDonationLabel: UILabel!
    @IBOutlet weak var totalDonationsLabel: UILabel!
    @IBOutlet weak var yearDonationsLabel: UILabel!
    @IBOutlet weak var donationStreakLabel: UILabel!
    @IBOutlet weak var donationStreakNo: UILabel!
    @IBOutlet weak var totalView: TotalView!
    @IBOutlet weak var yearlyView: YearlyView!
    @IBOutlet weak var streakView: StreakView!

    

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
        nameLabel.alpha = 0
        bloodTypeLabel.alpha = 0
        locationLabel.alpha = 0
        lastDonationLabel.alpha = 0
        totalDonationsLabel.alpha = 0
        yearDonationsLabel.alpha = 0
        donationStreakLabel.alpha = 0
        donationStreakNo.alpha = 0
        donationStreakNo.alpha = 0
        totalView.alpha = 0
        yearlyView.alpha = 0
        streakView.alpha = 0
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
            
            UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
                self.userDataView.alpha = 1
                self.statsView.alpha = 1
                self.tableTitleView.alpha = 1
                }) { (Bool) -> Void in
                    UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
                        self.nameLabel.alpha = 1
                        self.bloodTypeLabel.alpha = 1
                        self.locationLabel.alpha = 1
                        self.lastDonationLabel.alpha = 1
                        self.totalDonationsLabel.alpha = 1
                        self.yearDonationsLabel.alpha = 1
                        self.donationStreakLabel.alpha = 1
                        self.donationStreakNo.alpha = 1
                        self.tableView.alpha = 1
                        }) { (Bool) -> Void in
                            UIView.animateWithDuration(0.3, animations: { () -> Void in
                                self.totalView.alpha = 1
                                self.yearlyView.alpha = 1
                                self.streakView.alpha = 1
                            })
                    }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0, options: [], animations: { () -> Void in
            self.userDataView.alpha = 0
            self.statsView.alpha = 0
            self.tableTitleView.alpha = 0
            self.tableView.alpha = 0
            self.totalView.alpha = 0
            self.yearlyView.alpha = 0
            self.streakView.alpha = 0
            }) { (Bool) -> Void in
                
                // ..
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
        
        return objects.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! DonateHistoryTableViewCell
        
        let object = objects[indexPath.row]
        
        cell.titleLabel?.text =  object["name"]!
        cell.typeTextLabel?.text = object["desc"]!
        cell.bloodTypeLetter?.text = object["type"]!
        
        // cell.imageView?.image = UIImage(named: object["image"]!)
        
        cell.typeTextLabel.lineBreakMode = .ByWordWrapping
        cell.typeTextLabel.numberOfLines = 0
        cell.typeTextLabel.sizeToFit()
        
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
