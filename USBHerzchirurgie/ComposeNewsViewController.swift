//
//  ComposeNewsViewController.swift
//  Herzchirurgie
//
//  Created by Felix on 21/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class ComposeNewsViewController: UIViewController, UITextViewDelegate {
    var myScheduleBtnImage = UIImage(named: "sent-32.png")
    var theuser = PFUser.currentUser().username as String!
    @IBOutlet weak var composeTextView: UITextView!
    
    @IBOutlet weak var charRemainingLabel: UILabel!
    //var user = PFUser.currentUser()
    
    func composeDone () {
        
        //        var push:PFPush = PFPush()
        //        push.setChannel("Assist")
        //        //var data:NSDictionary = ["alert":"New Mitteilung", "badge":"0", "content-available":"1","sound":""]
        //        push.setMessage("Hi How are you?")
        //        push.sendPushInBackground()
        //      v
        //var user:PFUser = PFUser ()
        if ((self.composeTextView.text as String!) != ""){
        var news:PFObject = PFObject(className: "News")
        news["message"] = composeTextView.text as String!
        news["user"] = PFUser.currentUser().username
        
        news.saveInBackground()
        
//        var pushQuery:PFQuery = PFInstallation.query()
//        var push:PFPush = PFPush()
//        push.setChannel("Assist")
//        var data:NSDictionary = ["alert":composeTextView.text as String!, "badge":"0", "content-available":"1","sound":""]
//        push.setMessage(composeTextView.text as String!)
//        push.sendPushInBackground()
        var mymessage = composeTextView.text as String! + "\n" + self.theuser
        //var theuser = PFUser.currentUser().username as String!
    
        PFCloud.callFunctionInBackground("sendPushToUser", withParameters:["message": mymessage])
        
        } else {
            
            let alertController = UIAlertController(title: "Herzchirurgie", message:
                "Hoppla! Das war wohl nix!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        
        self.performSegueWithIdentifier("gobacktoNews", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //println(theuser)
        
//        var homeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: Selector("composeDone"))
//        self.navigationItem.rightBarButtonItem = homeButton
        
        var logButton : UIBarButtonItem = UIBarButtonItem(image: myScheduleBtnImage, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("composeDone"))
        self.navigationItem.rightBarButtonItem = logButton
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.composeTextView.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }
    
    func textView(textView: UITextView!,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String!) -> Bool{
            
            var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            var remainingChar:Int = 140 - newLength
            
            charRemainingLabel.text = "\(remainingChar)"
            
            return (newLength > 140) ? false : true
    }
    
    
    // returns the number of 'columns' to display.
    //    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
    //        return 1
    //    }
    //
    // returns the # of rows in each component..
    //    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    //        return groups.count
    //    }
    //
    //    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    //        return groups[row]
    //    }
    //
    //    override func didReceiveMemoryWarning() {
    //        super.didReceiveMemoryWarning()
    //        // Dispose of any resources that can be recreated.
    //    }
    //
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
