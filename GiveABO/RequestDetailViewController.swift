//
//  RequestDetailViewController.swift
//  GiveABO
//
//  Created by Sybico, Christopher on 10/30/15.
//  Copyright © 2015 Sybico, Christopher. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    
    var requestView: UIView!
    var initialCenter: CGPoint!
    
    
    var blobImage: UIImage!
    var blobImageView: UIImageView!
    
    
    var nameText = ""
    var messageText = ""
    
    
    var requestContents: [UILabel]!

    
    // VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        requestView = UIView()
        
        requestContents = [nameLabel, dateLabel, messageLabel]
        
        for content in requestContents {
            content.alpha = 0
        }
        
        
        nameLabel.text = nameText
        messageLabel.text = messageText
        
        let requestViewPan = UIPanGestureRecognizer(target: self, action: "didPanRequest:")
        requestView.addGestureRecognizer(requestViewPan)
    }
    
    
    // VIEW DID APPEAR
    override func viewDidAppear(animated: Bool) {

        var delay = 0.0
        
        for content in requestContents {
            
            UIView.animateWithDuration(
                0.5,
                delay: delay,
                options: UIViewAnimationOptions.CurveEaseIn,
                animations: { () -> Void in
                    content.alpha = 1
                },
                completion: nil
            )
            delay += 0.1
        }
    }
    
    @IBAction func didPressX(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
