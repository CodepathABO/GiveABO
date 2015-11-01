//
//  RequestDetailViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 10/31/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class RequestDetailViewController: UIViewController {
    
    var requestView: UIView!
    var initialCenter: CGPoint!
    //    var requestViewFrame: CGRect!
    //    var requestViewFrameOffsetX: CGFloat!
    
    var blobImage: UIImage!
    var blobImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        requestView = UIView()

    let requestViewPan = UIPanGestureRecognizer(target: self, action: "didPanRequest:")
    requestView.addGestureRecognizer(requestViewPan)
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
