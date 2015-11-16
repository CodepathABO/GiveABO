//
//  FilterViewController.swift
//  GiveABO-3
//
//  Created by Sybico, Christopher on 11/15/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var filterContentView: UIView!
   
    @IBOutlet weak var filterDoneView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        filterContentView.alpha = 0
        filterContentView.transform = CGAffineTransformMakeTranslation(0, 40)
        
        filterDoneView.alpha = 0
        filterDoneView.transform = CGAffineTransformMakeTranslation(0, 40)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        
        // ANIMATE FILTER VIEW
        
        UIView.animateWithDuration(
            
            0.8,
            delay: 0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                self.filterContentView.alpha = 1
                self.filterContentView.transform = CGAffineTransformMakeTranslation(0, 0)
            }
        )
        {
            (finished: Bool) -> Void in
                
        }
        
        
        // ANIMATE DONE VIEW
        
        UIView.animateWithDuration(
            
            0.8,
            delay: 0.4,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.2,
            options: UIViewAnimationOptions.CurveEaseInOut,
            
            animations: { () -> Void in
                self.filterDoneView.alpha = 1
                self.filterDoneView.transform = CGAffineTransformMakeTranslation(0, 0)
            }
            )
            {
                (finished: Bool) -> Void in
                
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didPressBloodType(sender: UIButton) {
        sender.selected = !sender.selected
    }

    @IBAction func didPressDone(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
