//
//  NewsWebViewController.swift
//  USBHerzchirurgie
//
//  Created by Felix on 31/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class NewsWebViewController:UIViewController, UIWebViewDelegate  {
    
    @IBOutlet weak var newsWebView: UIWebView!
    
    func gotoCompose () {
        self.performSegueWithIdentifier("gotoCompose", sender: self)
    }

    
    var activityIndicator1: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    
  
    
    
    
    var theURL = "http://herz.appiagyei.com/faqs.php"
    
    func loadWebPage () {
    let theRequestURL = NSURL (string: theURL)
    let theRequest = NSURLRequest(URL:theRequestURL!)
    newsWebView.loadRequest(theRequest)
    newsWebView.scalesPageToFit = true
    
    
    }
    
    func clearNotifications () {
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func reFresh () {
    self.newsWebView.reload()
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
    var homeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("gotoCompose"))
    self.navigationItem.rightBarButtonItem = homeButton
    
        
    self.clearNotifications()
    loadWebPage()
    self.activityIndicator1.frame = CGRectMake(100, 100, 100, 100)
    self.activityIndicator1.color = UIColor.redColor()
    self.view.addSubview(activityIndicator1)
    
    // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIWebViewDelegate
    
    func webViewDidStartLoad(myWebView: UIWebView) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    activityIndicator1.startAnimating()
    }
    
    func webViewDidFinishLoad(myWebView: UIWebView) {
    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    activityIndicator1.stopAnimating()
    }
    
    func webView(newsWebView: UIWebView, didFailLoadWithError error: NSError) {
    // Report the error inside the web view.
    let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
    
    let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
    
    newsWebView.loadHTMLString(errorHTML, baseURL: nil)
    
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
