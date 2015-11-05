//
//  HomeViewController.swift
//  abo-v2
//
//  Created by Sybico, Christopher on 10/30/15.
//  Copyright © 2015 Sybico, Christopher. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    
    // REQUEST SCROLL
    @IBOutlet weak var homeScrollView: UIScrollView!
    var homeScrollViewOffsetX: CGFloat!
    
    
    // REQUESTS
//    @IBOutlet weak var timRequestView: UIView!
    @IBOutlet weak var jeremieRequestView: UIView!
    @IBOutlet weak var annabelRequestView: UIView!
//    @IBOutlet weak var carolineRequestView: UIView!
//    @IBOutlet weak var markRequestView: UIView!
//    @IBOutlet weak var ucsfRequestView: UIView!
    
    // BLOBS
    var blob: UIImageView!
    var blobCoat: UIImageView!
    
    
    // SELECTED REQUESTS
    var selectedView: UIView!
    var selectedViewOriginalFrame: CGRect!
    var selectedBlobImageView: UIImageView!
    var selectedBlobImage: UIImage!
    var selectedBloblFrame: CGRect!
    var selectedNameLabel: UILabel!
    
    // CUSTOM TRANSITION
    var blobTransition: BlobTransition!
    
    
    // DID LOAD
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // SETUP STATUS BAR
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        
        // SETUP HOME SCROLLVIEW
        homeScrollView.contentSize = CGSize(width: 1665, height: 381)
        homeScrollView.delegate = self
        homeScrollViewOffsetX = 0
        
        
        // SET UP TAP GESTURE RECOGNISER
//        let timtap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let jeremieTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let annabelTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
//        let carolineTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
//        let markTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
//        let ucsfTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        
        
        // SET UP TAPS FOR REQUESTS
//        timRequestView.addGestureRecognizer(timtap)
        jeremieRequestView.addGestureRecognizer(jeremieTap)
        annabelRequestView.addGestureRecognizer(annabelTap)
//        carolineRequestView.addGestureRecognizer(carolineTap)
//        markRequestView.addGestureRecognizer(markTap)
//        ucsfRequestView.addGestureRecognizer(ucsfTap)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {

//        showBlobs(timRequestView)
        showBlobs(jeremieRequestView)
        showBlobs(annabelRequestView)
//        showBlobs(carolineRequestView)
//        showBlobs(markRequestView)
//        showBlobs(ucsfRequestView)
    }
    
    func showBlobs(requestView: UIView) {
        
        
        
        let blob = requestView.viewWithTag(10) as! UIImageView
        let blobCoat = requestView.viewWithTag(11) as! UIImageView
        
        let rotation = 180
        blob.alpha = 1
        
        
        // BLOB SIZE
        UIView.animateWithDuration(
            2,
            delay: 0,
            options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
            animations: { () -> Void in
                
                blob.transform = CGAffineTransformScale(blob.transform, 1.05, 1.03)
            },
            
            completion: nil
        )
        
        
        
        
        // BLOB COAT ROTATION
        UIView.animateWithDuration(
            16,
            delay: 0,
            options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
            animations: { () -> Void in
                
                blobCoat.transform = CGAffineTransformMakeRotation(CGFloat(Double(rotation) * M_PI / 180))
            },
            
            completion: nil
        )
    }
    
    
    // LISTEN TO HOME SCROLL
    func scrollViewDidScroll(scrollView: UIScrollView) {
        homeScrollViewOffsetX = homeScrollView.contentOffset.x
    }
    
    
    // TAP ON REQUEST
    func didTapRequest(sender: UITapGestureRecognizer) {
        
        // STORE SELECTED VIEW
        selectedView = sender.view
        selectedViewOriginalFrame = selectedView.frame
        selectedBlobImageView = selectedView.viewWithTag(10) as! UIImageView
        selectedBlobImage = selectedBlobImageView.image
        selectedBloblFrame = selectedBlobImageView.frame

        
        // SEGUE TO REQUEST DETAIL
        performSegueWithIdentifier("requestDetailSegue", sender: nil)
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! RequestDetailViewController
        
        // SEND IMAGE
        destinationVC.blobImage = selectedBlobImage

        
        // SEND NAME
        selectedNameLabel = selectedView.viewWithTag(20) as! UILabel
        destinationVC.nameText = selectedNameLabel.text!
        
        
        // SEND MESSAGE
        let selectedMessage = selectedView.viewWithTag(30) as! UILabel
        destinationVC.messageText = selectedMessage.text!
        
        
        
        // SETUP BLOB TRANSITION
        blobTransition = BlobTransition()
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = blobTransition
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
