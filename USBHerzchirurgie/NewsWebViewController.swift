//
//  NewsWebViewController.swift
//  USBHerzchirurgie
//
//  Created by Felix on 31/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class NewsWebViewController:UIViewController, UIWebViewDelegate  {
    
    var newsActivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)

    
    
    @IBOutlet weak var newsWebView: UIWebView!
    
    func gotoCompose () {
        self.performSegueWithIdentifier("gotoCompose", sender: self)
    }
    
    func gotoMain () {
        self.performSegueWithIdentifier("gotoMain", sender: self)
    }

    
    func clearNotifications () {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
  
    
    
    
    var theURL = "http://herz.appiagyei.com/news"
    
    func loadWebPage () {
        let theRequestURL = NSURL (string: theURL)
        let theRequest = NSURLRequest(URL:theRequestURL!)
        newsWebView.loadRequest(theRequest)
        newsWebView.scalesPageToFit = true
        
        
    }
    
    func reFresh () {
        self.newsWebView.reload()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var homeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("gotoCompose"))
        self.navigationItem.rightBarButtonItem = homeButton
        
        var gotoMainBtn: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Rewind, target: self, action: Selector("gotoMain"))
        self.navigationItem.leftBarButtonItem = gotoMainBtn
        
        
        self.clearNotifications ()
        
        loadWebPage()
        self.newsActivityIndicator.frame = CGRectMake(100, 100, 100, 100)
        self.newsActivityIndicator.color = UIColor.redColor()
        self.view.addSubview(newsActivityIndicator)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIWebViewDelegate
    
    func webViewDidStartLoad(newsWebView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        newsActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(newsWebView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        newsActivityIndicator.stopAnimating()
    }
    
    func webView(newsWebView: UIWebView, didFailLoadWithError error: NSError) {
        // Report the error inside the web view.
        let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
        
        let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
        
        newsWebView.loadHTMLString(errorHTML, baseURL: nil)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    //    func webViewDidStartLoad(_ : UIWebView){
    //        newsActivityIndicator.startAnimating()
    //    }
    //
    //    func webViewDidFinishload(_ : UIWebView){
    //        newsActivityIndicator.stopAnimating()
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //self.reFresh()
        self.clearNotifications ()
    }
    
}
