//
//  RequestDetailViewController.swift
//  GiveABO
//
//  Created by Sybico, Christopher on 10/30/15.
//  Copyright © 2015 Sybico, Christopher. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {

    
    // VARS
    var requestView: UIView!
    var initialCenter: CGPoint!
    var blobImage: UIImage!
    var blobImageView: UIImageView!
    var requestContents: [UILabel]!

    
    // OUTLETS
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    // VIEW DID LOAD
    override func viewDidLoad() {
        
        super.viewDidLoad()

        requestView = UIView()

        let requestViewPan = UIPanGestureRecognizer(target: self, action: "didPanRequest:")
        requestView.addGestureRecognizer(requestViewPan)
        
        
        requestContents = [nameLabel, dateLabel, messageLabel]
        
        // SET OPACITY
        nameLabel.alpha = 0
        dateLabel.alpha = 0
        messageLabel.alpha = 0
        
    }
    
    override func viewDidAppear(animated: Bool) {
        requestContent()
    }
    
    
    // SHOW REQUEST CONTENT
    func requestContent() {
        
        var delay = 0.0
        
        for content in requestContents {
            
            // FADE IN TEXTS
            UIView.animateWithDuration(
                
                0.6,
                delay: delay,
                options: UIViewAnimationOptions.CurveEaseInOut,
                animations: { () -> Void in
                    content.alpha = 1
                },
                
                completion: nil
            )
        
            delay += 0.1
            
        }
    }
    

    // PAN ON REQUEST
    func didPanRequest(sender: UIPanGestureRecognizer) {
    
        let translation = sender.translationInView(view)
    
    
        // BEGIN PANNING
        if sender.state == UIGestureRecognizerState.Began {
        
            initialCenter = requestView.center
        
        }
        
        // PANNING
        else if sender.state == UIGestureRecognizerState.Changed {
            print("panning")
        
            requestView.center.y = initialCenter.y + translation.y
        
        }
        
        // END PANNING
        else if sender.state == UIGestureRecognizerState.Ended {
            dismissViewControllerAnimated(true, completion: nil)
        }
    
    }
}
