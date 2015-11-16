//
//  UserRewardsViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserRewardsViewController: UIViewController {

    @IBOutlet weak var awardsNumberView: UIView!
    @IBOutlet weak var donationsLabel: UILabel!
    @IBOutlet weak var AwardsvViewContain: UITableViewCell!
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var rewardButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        awardsNumberView.layer.cornerRadius = awardsNumberView.frame.size.width / 2
        
        awardsNumberView.layer.borderColor = UIColor(red:0.97, green:0.95, blue:0.95, alpha:1.0).CGColor
        awardsNumberView.layer.borderWidth = 8
        
        
        donationsLabel.lineBreakMode = .ByWordWrapping
        donationsLabel.numberOfLines = 0
        donationsLabel.sizeToFit()
       
        AwardsvViewContain.alpha = 0
        counterView.alpha = 0
        
        rewardButton.layer.cornerRadius = 25
        

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.AwardsvViewContain.alpha = 1
            }) { (Bool) -> Void in
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.counterView.alpha = 1
                })

        }
    }

    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.AwardsvViewContain.alpha = 0
            self.counterView.alpha = 0
            }) { (Bool) -> Void in
                // ..
        }
    }
    
    
    
    // MARK: ACTIONS
    
    @IBAction func closeButton(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
