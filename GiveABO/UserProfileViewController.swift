//
//  UserProfileViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = ["Blood bank: Cal Pacific Blood bank", "Direct Request", "Direct Request", "Blood bank: SF General", "Blood drive: American Red Cross"]


    @IBOutlet weak var totalDonationsView: UIView!
    @IBOutlet weak var yearlyDonationsView: UIView!
    @IBOutlet weak var donationStreakView: UIView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false

        tableView.delegate = self
        tableView.dataSource = self
        
        
        donationStreakView.layer.cornerRadius = donationStreakView.frame.size.width / 2
        
        donationStreakView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        donationStreakView.layer.borderWidth = 8
        
        yearlyDonationsView.layer.cornerRadius = yearlyDonationsView.frame.size.width / 2
        
        yearlyDonationsView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        yearlyDonationsView.layer.borderWidth = 8
        
        totalDonationsView.layer.cornerRadius = totalDonationsView.frame.size.width / 2
        
        totalDonationsView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        totalDonationsView.layer.borderWidth = 8
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = data[indexPath.row]
        cell.accessoryType = .Checkmark
        
        return cell
        
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
