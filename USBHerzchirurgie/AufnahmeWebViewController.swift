//
//  AufnahmeWebViewController.swift
//  USBHerzchirurgie
//
//  Created by Felix on 30/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class AufnahmeWebViewController: UIViewController, UIWebViewDelegate  {
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    
    
    
    @IBOutlet weak var myWebView: UIWebView!
    
    
    
    
    var theURL = "http://herz.appiagyei.com/"
    
    func loadWebPage () {
        let theRequestURL = NSURL (string: theURL)
        let theRequest = NSURLRequest(URL:theRequestURL!)
        myWebView.loadRequest(theRequest)
        myWebView.scalesPageToFit = true
        
        
    }
    
    func reFresh () {
        self.myWebView.reload()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var homeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("reFresh"))
        self.navigationItem.rightBarButtonItem = homeButton
        
        loadWebPage()
        self.activityIndicator.frame = CGRectMake(100, 100, 100, 100)
        self.activityIndicator.color = UIColor.redColor()
        self.view.addSubview(activityIndicator)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIWebViewDelegate
    
    func webViewDidStartLoad(myWebView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(myWebView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.stopAnimating()
    }
    
    func webView(myWebView: UIWebView, didFailLoadWithError error: NSError) {
        // Report the error inside the web view.
        let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
        
        let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
        
        myWebView.loadHTMLString(errorHTML, baseURL: nil)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    //    func webViewDidStartLoad(_ : UIWebView){
    //        activityIndicator.startAnimating()
    //    }
    //
    //    func webViewDidFinishload(_ : UIWebView){
    //        activityIndicator.stopAnimating()
    //    }
    //
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
