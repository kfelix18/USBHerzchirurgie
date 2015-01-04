//
//  FAQWebViewViewController.swift
//  Herzchirurgie
//
//  Created by Felix on 13/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//


import UIKit

class FAQWebViewViewController: UIViewController, UIWebViewDelegate  {
    
    var faqActivityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    
    
    
    @IBOutlet weak var faqWebView: UIWebView!
    
    
    
    
    var theURL = "http://herz.appiagyei.com/faq"
    
    func loadWebPage () {
        let theRequestURL = NSURL (string: theURL)
        let theRequest = NSURLRequest(URL:theRequestURL!)
        faqWebView.loadRequest(theRequest)
        faqWebView.scalesPageToFit = true
        
        
    }
    
    func reFresh () {
        self.faqWebView.reload()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var homeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("reFresh"))
        self.navigationItem.rightBarButtonItem = homeButton
        
        loadWebPage()
        self.faqActivityIndicator.frame = CGRectMake(100, 100, 100, 100)
        self.faqActivityIndicator.color = UIColor.redColor()
        self.view.addSubview(faqActivityIndicator)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIWebViewDelegate
    
    func webViewDidStartLoad(faqWebView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        faqActivityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(faqWebView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        faqActivityIndicator.stopAnimating()
    }
    
    func webView(faqWebView: UIWebView, didFailLoadWithError error: NSError) {
        // Report the error inside the web view.
        let localizedErrorMessage = NSLocalizedString("An error occured:", comment: "")
        
        let errorHTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 36pt;\">\(localizedErrorMessage) \(error.localizedDescription)</div></body></html>"
        
        faqWebView.loadHTMLString(errorHTML, baseURL: nil)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    //    func webViewDidStartLoad(_ : UIWebView){
    //        faqActivityIndicator.startAnimating()
    //    }
    //
    //    func webViewDidFinishload(_ : UIWebView){
    //        faqActivityIndicator.stopAnimating()
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
