//
//  HomeViewController.swift
//  abo-v2
//
//  Created by Sybico, Christopher on 10/30/15.
//  Copyright © 2015 Sybico, Christopher. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UIScrollViewDelegate {
    
    
    // REQUEST SCROLL
    @IBOutlet weak var homeScrollView: UIScrollView!
    var homeScrollViewOffsetX: CGFloat!
    
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var requestLabel: UILabel!
    @IBOutlet weak var createRequestButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!
    
    // REQUESTS
//    @IBOutlet weak var timRequestView: UIView!
    @IBOutlet weak var jeremieRequestView: UIView!
    @IBOutlet weak var annabelRequestView: UIView!
    @IBOutlet weak var americanRCRequestView: UIView!
    @IBOutlet weak var carolineRequestView: UIView!
    @IBOutlet weak var ucsfRequestView: UIView!
    @IBOutlet weak var gioRequestView: UIView!
    @IBOutlet weak var markRequestView: UIView!
    @IBOutlet weak var helenRequestView: UIView!
    @IBOutlet weak var oaklandRequestView: UIView!
    @IBOutlet weak var newRequestView: UIView!
    
    
    // BLOBS
    var blob: UIImageView!
    var blobCoat: UIImageView!
    var requests: [UIView]!
    
    
    @IBOutlet weak var blurredBlob1: UIImageView!
    @IBOutlet weak var blurredBlob2: UIImageView!
    var blurredBlobs: [UIImageView]!
    
    
    // SELECTED REQUESTS
    var selectedView: UIView!
    var selectedViewOriginalFrame: CGRect!
    var selectedBlobImageView: UIImageView!
    var selectedBlobImage: UIImage!
    var selectedBloblFrame: CGRect!
    var selectedNameLabel: UILabel!
    var selectedMessageLabel: UILabel!
    var selectedBloodTypeLabel: UILabel!
    
    
    
    // CUSTOM TRANSITION
    var blobTransition: BlobTransition!
    

    // PARSE USERS
    var user = PFUser.currentUser()
    var query = PFQuery(className:"Simple")
    
    
    
    
    // DID LOAD -----------------------------------------------------------------------------------------------------
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // SETUP HOME SCROLLVIEW
        homeScrollView.contentSize = CGSize(width: 1665, height: 381)
        homeScrollView.delegate = self
        homeScrollViewOffsetX = 0
        
        
        // SET UP TAP GESTURE RECOGNISER
        let jeremieTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let annabelTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let americanRCTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let carolineTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let ucsfTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let gioTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let markTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let helenTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let oaklandTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        let newRequesTap = UITapGestureRecognizer(target: self, action: "didTapRequest:")
        
        
        // SET UP TAPS FOR REQUESTS
        jeremieRequestView.addGestureRecognizer(jeremieTap)
        annabelRequestView.addGestureRecognizer(annabelTap)
        americanRCRequestView.addGestureRecognizer(americanRCTap)
        carolineRequestView.addGestureRecognizer(carolineTap)
        ucsfRequestView.addGestureRecognizer(ucsfTap)
        gioRequestView.addGestureRecognizer(gioTap)
        markRequestView.addGestureRecognizer(markTap)
        helenRequestView.addGestureRecognizer(helenTap)
        oaklandRequestView.addGestureRecognizer(oaklandTap)
        newRequestView.addGestureRecognizer(newRequesTap)
        
        
        // SET UP ARRAYS
        requests = [jeremieRequestView, americanRCRequestView]
        blurredBlobs = [blurredBlob1, blurredBlob2]
        
        
        // SET UP INTRO
        profileButton.alpha = 0
        requestLabel.alpha = 0
        createRequestButton.alpha = 0
        filterButton.alpha = 0
        
        blurredBlob1.alpha = 0
        blurredBlob1.transform = CGAffineTransformMakeTranslation(20, 0)
        
        blurredBlob2.alpha = 0
        blurredBlob2.transform = CGAffineTransformMakeTranslation(40, 0)
        
        jeremieRequestView.alpha = 0
        jeremieRequestView.transform = CGAffineTransformMakeTranslation(200, 0)
        
        americanRCRequestView.alpha = 0
        americanRCRequestView.transform = CGAffineTransformMakeTranslation(200, 0)
        
        
        // TIMER
//        NSTimer.scheduledTimerWithTimeInterval(0.02, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
    }
    
    
    func onTimer() {
//        blurredBlob1.center.x -= 0.1
//        blurredBlob2.center.x -= 0.1
//        print(blurredBlob1.center.x)
    }
    
  
    
    // VIEW DID APPEAR -----------------------------------------------------------------------------------------------
    
  
    override func viewDidAppear(animated: Bool) {

        bloblAnimation1(jeremieRequestView)
        bloblAnimation1(annabelRequestView)
        bloblAnimation1(carolineRequestView)
        bloblAnimation1(gioRequestView)
        bloblAnimation1(helenRequestView)
        bloblAnimation1(markRequestView)
        blobAnimation2(americanRCRequestView)
        blobAnimation2(oaklandRequestView)
        
        
        
        // CALL HOME INTRO
        homeIntro()
        
        
        // SETUP STATUS BAR
        UIApplication.sharedApplication().statusBarStyle = .Default
        UIApplication.sharedApplication().statusBarHidden = false
        
        
        // CHECK IF THERE'S A NEW REQUEST
        if newRequestListener == true {
            
            // UPDATE NEW REQUEST INFO
            let nameLabel = newRequestView.viewWithTag(20) as! UILabel
            nameLabel.text = newRequestName
            
            let messageLabel = newRequestView.viewWithTag(30) as! UILabel
            messageLabel.text = newRequestMessage
            
            let bloodTypeLabel = newRequestView.viewWithTag(40) as! UILabel
            bloodTypeLabel.text = newRequestBloodType
            
            
            // NEW BLOB REQUEST COMES IN
            self.newRequestView.alpha = 0
            self.newRequestView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            
            UIView.animateWithDuration(
                3,
                delay: 0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.6,
                options: UIViewAnimationOptions.CurveEaseInOut,
                
                animations: { () -> Void in
                    
                    self.jeremieRequestView.transform = CGAffineTransformMakeTranslation(90, -15)
                    self.americanRCRequestView.transform = CGAffineTransformMakeTranslation(60, 10)
                    
                    self.newRequestView.alpha = 1
                    self.newRequestView.transform = CGAffineTransformMakeTranslation(300, 0)
                    self.newRequestView.transform = CGAffineTransformScale(self.newRequestView.transform, 1, 1)
                    
                },
                
                completion: nil
            )
        }
        
    }
    
    
    
    
    // HOME INTRO FUNCTON ---------------------------------------------------------------------------------------------
    
    
    
    func homeIntro() {
        
        // ANIMATE NAVBAR
        UIView.animateWithDuration(
            2.4,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                
                self.profileButton.alpha = 1
                self.requestLabel.alpha = 1
                self.createRequestButton.alpha = 1
            },
            
            completion: nil
        )
        
        // ANIMATE BLOBS
        var requestDelay = 0.5
        for request in requests {
            
            UIView.animateWithDuration(
                2.4,
                delay: requestDelay,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
                
                animations: { () -> Void in
                    
                    let translate = CGAffineTransformMakeTranslation(0, 0)
                    let scale = CGAffineTransformMakeScale(1, 1)
                    
                    request.alpha = 1
                    request.transform = CGAffineTransformConcat(translate, scale)
                    
                },
                
                completion: nil
            )
            requestDelay += 0.1
        }
        
        // ANIMATE FILTER
        UIView.animateWithDuration(
            2.4,
            delay: 1.6,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                
                self.filterButton.alpha = 1
            },
            
            completion: nil
        )
        
        // ANIMATE BLURRED BLOBS
        var blurredBlobsDelay = 0.4
        for blob in blurredBlobs {
            
            UIView.animateWithDuration(
                5.0,
                delay: blurredBlobsDelay,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.2,
                options: UIViewAnimationOptions.CurveEaseInOut,
                
                animations: { () -> Void in
                    
                    let translate = CGAffineTransformMakeTranslation(0, 0)
                    let scale = CGAffineTransformMakeScale(1, 1)
                    
                    blob.alpha = 1
                    blob.transform = CGAffineTransformConcat(translate, scale)
                    
                },
                
                completion: nil
            )
            blurredBlobsDelay += 0.4
        }
        
        
        
    }
    
    
    // BLOB ANIMATION FUNCTION ----------------------------------------------------------------------------------------
    
    
    func bloblAnimation1(requestView: UIView) {
        
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
    
    
    // BLOB ANIMATION 2 -----------------------------------------------------------------------------------------------
    
    
    func blobAnimation2(requestView: UIView) {
        
        let blob = requestView.viewWithTag(10) as! UIImageView
        let blobCoat = requestView.viewWithTag(11) as! UIImageView
        
        let rotation = 90
        blob.alpha = 1
        
        // BLOB SIZE
        UIView.animateWithDuration(
            4,
            delay: 0,
            options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
            animations: { () -> Void in
                
                blob.transform = CGAffineTransformScale(blob.transform, 1.01, 1.03)
            },
            
            completion: nil
        )
        
        // BLOB COAT ROTATION
        UIView.animateWithDuration(
            20,
            delay: 0,
            options: [UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
            animations: { () -> Void in
                
                blobCoat.transform = CGAffineTransformMakeRotation(CGFloat(Double(rotation) * M_PI / 180))
            },
            
            completion: nil
        )
    }
    
    
    
    
    
    
    // HOME SCROLL ------------------------------------------------------------------------------------------------
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        homeScrollViewOffsetX = homeScrollView.contentOffset.x

        let translation1 = (homeScrollView.contentOffset.x/10)
        let translation2 = (homeScrollView.contentOffset.x/40)
        
        blurredBlob1.transform = CGAffineTransformMakeTranslation(translation1, 0)
        blurredBlob2.transform = CGAffineTransformMakeTranslation(translation2, 0)
        
    }
    
    
    
    
    // TAP ON REQUEST ------------------------------------------------------------------------------------------------
    
    
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
    
    
    // TAP ON CREATE NEW REQUEST ------------------------------------------------------------------------------------
    
    
    @IBAction func didPressCreateRequest(sender: AnyObject) {
        
        // IF LOGGED IN, GO TO CREATE NEW REQUEST
        if user != nil  {
            performSegueWithIdentifier("createRequestSegue", sender: nil)
        }
            
        // IF LOGGED OUT, GO TO SIGN UP
        else {
            goToSignup()
        }

    }
    
    
    
    
    // GO TO SIGNUP STORYBOARD -------------------------------------------------------------------------------
    
    
    func goToSignup() {
        
        let storyboard = UIStoryboard(name: "Signup", bundle: nil)
        
        let controller = storyboard.instantiateViewControllerWithIdentifier("SignUpNavigationViewController") as UIViewController
        
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
    
    
    // TAP ON PROFILE  -------------------------------------------------------------------------------
    
    
    @IBAction func didPressProfile(sender: AnyObject) {
        
        
        // IF LOGGED IN, GO TO PROFILE
        if user != nil  {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewControllerWithIdentifier("UserAccountViewController") as UIViewController
            self.presentViewController(controller, animated: true, completion: nil)
        }
            
            // IF LOGGED OUT, GO TO SIGN UP
        else {
            goToSignup()
        }
    }
    
    
    
    
    // PREPARE FOR SEGUE  -------------------------------------------------------------------------------
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if (segue.identifier == "requestDetailSegue") {
            
            let destinationVC = segue.destinationViewController as! RequestDetailViewController
            
            // SEND IMAGE
            destinationVC.blobImage = selectedBlobImage
            
            // SEND NAME
            selectedNameLabel = selectedView.viewWithTag(20) as! UILabel
            destinationVC.nameText = selectedNameLabel.text!
            
            // SEND MESSAGE
            selectedMessageLabel = selectedView.viewWithTag(30) as! UILabel
            destinationVC.messageText = selectedMessageLabel.text!
            
            // SEND BLOOD TYPE
            selectedBloodTypeLabel = selectedView.viewWithTag(40) as! UILabel
            destinationVC.bloodTypeText = selectedBloodTypeLabel.text!
            
            
            // SETUP BLOB TRANSITION
            blobTransition = BlobTransition()
            destinationVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            destinationVC.transitioningDelegate = blobTransition
        
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
