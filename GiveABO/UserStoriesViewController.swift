//
//  UserStoriesViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class UserStoriesViewController: UIViewController, UICollectionViewDelegate,
    UICollectionViewDataSource {

    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var successPageTitle: UILabel!

    
    @IBOutlet weak var successTextLabel: UILabel!
    
    
    
    private var stories = [Story(storyID: "001", name: "Brenda Cole", city: "San Francisco", state: "CA", featureImage: UIImage(named: "image-1"), summary: "My baby was born with complications that required monthly transfusions. Before I found out about GiveABO, we had to wat lenghty periods of time or travel far distances just to be able to get the bloodtype she needed! Thnks to ABO, we can access a large comunity of donors in the area!", userType: UIImage(named: "heartInNeed")),
        Story(storyID: "002", name: "Andrew Smythe", city: "San Francisco", state: "CA", featureImage: UIImage(named: "image-2"), summary: "I required an emargency surgery that without this ABO app, I would have had to be sent to a hospital nowhere near my family. Special Thanks to my friend who found out about ABO and connected my to several great donors!", userType: UIImage(named: "heartInNeed")),
        Story(storyID: "004", name: "Tiana Zigler", city: "Lincoln City", state: "Ok", featureImage: UIImage(named: "image-3"), summary: "My husband and I regularly donate blod, ABO has allowed me to donate direct to users in need! I always feel like there is a bigger reason when I know the story behind somebody's need.", userType: UIImage(named: "heartAB+")),
        Story(storyID: "005", name: "Craig Myers", city: "Humboldt", state: "CA", featureImage: UIImage(named: "image-4"), summary: "I've been a pretty regular donor forever. When I got ABO it made it real easy to donate to not just blood banks, bot directly to other users in need. I became that needy user when one of my kids required surgery. ABO and its commuity came through! Thanks!", userType: UIImage(named: "heartO-n"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        successTextLabel.lineBreakMode = .ByWordWrapping
        successTextLabel.numberOfLines = 0
        successTextLabel.sizeToFit()
        
        storiesCollectionView.alpha = 0
        successTextLabel.alpha = 0
        successPageTitle.alpha = 0
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.storiesCollectionView.alpha = 1
            self.successTextLabel.alpha = 1
            self.successPageTitle.alpha = 1
            }) { (Bool) -> Void in
                // ..
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animateWithDuration(0.3, delay: 0.5, options: [], animations: { () -> Void in
            self.storiesCollectionView.alpha = 0
            self.successTextLabel.alpha = 0
            self.successPageTitle.alpha = 0
            }) { (Bool) -> Void in
                // ..
        }
    }
    
    
    
    // MARK: ACTIONS
    
    @IBAction func closeButton(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection
        section: Int) -> Int {
        
        return stories.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath
        indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",
        forIndexPath: indexPath) as! StoriesCollectionViewCell
        
        // Configure the cell
        cell.nameLabel.text = stories[indexPath.row].name
        cell.locationLabel.text = stories[indexPath.row].city + ". " + stories[indexPath.row].state
        cell.featureImage.image = stories[indexPath.row].featureImage
        cell.summaryLabel.text = stories[indexPath.row].summary
        cell.userTypeImage.image = stories[indexPath.row].userType
        
        
        // Apply round corner
        cell.layer.cornerRadius = 4.0
        cell.summaryLabel.lineBreakMode = .ByWordWrapping
        cell.summaryLabel.numberOfLines = 0
        cell.summaryLabel.sizeToFit()
        
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
