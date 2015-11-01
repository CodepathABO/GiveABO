//
//  HomeViewController.swift
//  GiveABO
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

    @IBOutlet weak var timRequestView: UIView!
    @IBOutlet weak var williamRequestView: UIView!
    @IBOutlet weak var oaklandRequestView: UIView!
    
    // SELECTED REQUESTS
    var selectedView: UIView!
    var selectedViewOriginalFrame: CGRect!
    var selectedBlobImageView: UIImageView!
    var selectedBlobImage: UIImage!
    
    
    // CUSTOM TRANSITION
    var blobTransition: BlobTransition!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // STATUSBAR STYLES
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false

        // SETUP HOME SCROLLVIEW
        homeScrollView.contentSize = CGSize(width: 1665, height: 381)
        homeScrollView.delegate = self
        homeScrollViewOffsetX = 0
        
        
        // SET UP TAP GESTURE RECOGNISER
        let williamTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let timtap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let oaklandTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        
        
        // SET UP TAPS FOR REQUESTS
        williamRequestView.addGestureRecognizer(williamTap)
        timRequestView.addGestureRecognizer(timtap)
        oaklandRequestView.addGestureRecognizer(oaklandTap)
        
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
        
        
        // SEGUE TO REQUEST DETAIL
        performSegueWithIdentifier("requestDetailSegue", sender: nil)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! RequestDetailViewController
        
        // SEND IMAGE
        destinationVC.blobImage = selectedBlobImage
        
        // SETUP BLOB TRANSITION
        blobTransition = BlobTransition()
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        destinationVC.transitioningDelegate = blobTransition
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
