//
//  UserEventsViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserEventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let data = ["UC Berkeley - November 21, 2015", "San Francisco State University - November 26, 2015", "University Hospital - December 12, 2015", "Fairfield Mall Mobile Donation - Decmber 15, 2015", "San Mateo County City Hall - December 17, 2015", "Cal Pacific - December 21, 2015", "Cow Palace - January 06, 2016", "Oakland Tech High School - January 16, 2016"]
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var eventsText: UILabel!
    
    var refresher: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "")
        
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.addSubview(refresher)

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.alpha = 0
        screenTitle.alpha = 0
        eventsText.alpha = 0
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.tableView.alpha = 1
            self.screenTitle.alpha = 1
            self.eventsText.alpha = 1
            }) { (Bool) -> Void in
                // ..
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.tableView.alpha = 0
            self.screenTitle.alpha = 0
            self.eventsText.alpha = 0
            }) { (Bool) -> Void in
                // ..
        }
    }
    
    // MARK: ACTIONS
    
    @IBAction func closeButton(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       //
        return data.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = data[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.Gray
        
        cell.accessoryType = .DisclosureIndicator
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }
    
    
    func refresh() {
        
       refresher.endRefreshing()
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
