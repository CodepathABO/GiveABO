//
//  PrivacyViewController.swift
//  GiveABO
//
//  Created by Sebastian Drew on 11/5/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var url: String!
    @IBOutlet weak var progressView: UIProgressView!
    var hasFinishedLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        url = "http://theorize.com/giveabo.html"
        let targetURL = NSURL(string: url)
        let request = NSURLRequest(URL: targetURL!)
        webView.loadRequest(request)
        
        webView.delegate = self
    }

    func webViewDidStartLoad(webView: UIWebView) {
        hasFinishedLoading = false
       updateProgress()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        delay(1) { [weak self] in
            if let _self = self {
                _self.hasFinishedLoading = true
            }
        }
    }

    // Memory saver
    
    deinit {
        webView.stopLoading()
        webView.delegate = nil
    }
    
    func updateProgress() {
        if progressView.progress >= 1 {
            progressView.hidden = true
        } else {
            
            if hasFinishedLoading {
                progressView.progress += 0.002
            } else {
                if progressView.progress <= 0.3 {
                    progressView.progress += 0.04
                } else if progressView.progress <= 0.6 {
                    progressView.progress += 0.02
                } else if progressView.progress <= 0.9 {
                    progressView.progress += 0.01
                } else if progressView.progress <= 0.98 {
                    progressView.progress += 0.001
                } else {
                    progressView.progress = 0.9801
                }
            }
            
            delay(0.008) { [weak self] in
                if let _self = self {
                    _self.updateProgress()
                }
            }
        }

    }
    
    @IBAction func closePrivacyButton(sender: UIButton) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
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
