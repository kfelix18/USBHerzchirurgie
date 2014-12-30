//
//  NewsWebViewController.swift
//  USBHerzchirurgie
//
//  Created by Felix on 31/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class NewsWebViewController: UIViewController {
    
    func gotoCompose () {
        self.performSegueWithIdentifier("gotoCompose", sender: self)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        var homeButton: UIBarButtonItem =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("gotoCompose"))
        self.navigationItem.rightBarButtonItem = homeButton

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
