//
//  FrontPageTableViewController.swift
//  USBHerzchirurgie
//
//  Created by Felix on 30/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class FrontPageTableViewController: UITableViewController, SideBarDelegate {
    
    // Hold the menu icon
    var theMenuIcon = UIImage(named: "menu-32.png")
    
    // Adding the Sidebar Navigation
    var sideBar:SideBar = SideBar()
    
    // Function to get the current day as a string
    
    func getCurrentDate() -> String {
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        var stringDate = formatter.stringFromDate(date)
        return stringDate
        
    }
    
    // I declared the variable I will be using to hold the valves for the table
    
    var dienstOA = ""
    var dienstAA = ""
    var AAhinter = ""
    var abwesend = ""
    var anwesend = ""
    var op = ""
    var visite = ""
    var aufname = ""
    
    // Define all the various Cells I will be Using
    var dienstOAundAACell: UITableViewCell = UITableViewCell()
    var anwesendCell: UITableViewCell = UITableViewCell()
    var abwesendCell: UITableViewCell = UITableViewCell()
    var opCell: UITableViewCell = UITableViewCell()
    var aufnahmeCell: UITableViewCell = UITableViewCell()
    var heuteCell: UITableViewCell = UITableViewCell()
    var verteilungCell: UITableViewCell = UITableViewCell()
    var visiteCell: UITableViewCell = UITableViewCell()
    
    
    // MARK - Parse.com functions that gets information from Parse.
    func getDienstData () {
        
        var theday = self.getCurrentDate()
        
        var query = PFQuery(className:"Dienste")
        query.whereKey("date", equalTo:theday)
        query.cachePolicy = kPFCachePolicyCacheElseNetwork
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                for people in objects {
                    self.dienstAA = people["AA"] as String!
                    self.dienstOA = people["OA"] as String!
                    self.dienstOAundAACell.textLabel?.text = self.dienstAA + ", " + self.dienstOA
                    self.abwesend = people["abwesend"] as String!
                    self.abwesendCell.textLabel?.text = self.abwesend
                }
                // Results were successfully found, looking first on the
                // network and then on disk.
            } else {
                // The network was inaccessible and we have no cached data for
                // this query.
                NSLog("getting todays dienst data does not work")
            }
        }
        
    }
    
    func getWeekGrping () {
        
        var date = self.getCurrentDate()
        //println(date)
        var query1 = PFQuery(className: "Verteilungen")
        query1.whereKey("date", equalTo:date)
        query1.cachePolicy = kPFCachePolicyNetworkElseCache
        query1.findObjectsInBackgroundWithBlock {
            (thisWeek: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for leute in thisWeek {
                    self.op = leute["op"] as String!
                    self.visite = leute["visite"] as String!
                    self.opCell.textLabel?.text = "Op: " + self.op
                    self.visiteCell.textLabel?.text = "Visite: " + self.visite
                    self.aufname = leute["aufnahme"] as String!
                    self.aufnahmeCell.textLabel?.text = "Eintritte: " + self.aufname
                    //println(leute)
                }
            } else {
                // The network was inaccessible and we have no cached data for
                // this query.
                
                NSLog("getting week's verteilungen is not working")
            }
        }
        
        
    }
    
    //This function just act by showing the side bar, used here when the menu button is tapped
    
    func bringSideBar () {
        sideBar.showSideBar(true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideBar = SideBar(sourceView: self.view, menuItems: ["Mitteilungen", "Dienstplan", "FAQs", "Aufnahme"])
        sideBar.delegate = self
        
        //This checks if the user is logged in, if not then it shows an alert with the option to sign in or sign upo
        if ((PFUser.currentUser() == nil)){
            self.showLoginSignUp()
            
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    // This is the alert fotr sign in or sign up
    func showLoginSignUp(){
        
        var loginAlert:UIAlertController = UIAlertController(title: "Anmeldung", message: "Bitte melden Sie sich an oder einloggen", preferredStyle: UIAlertControllerStyle.Alert)
        
        loginAlert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "z.B Meu, Hsi oder Apf"
            //textField.keyboardType = .EmailAddress
        }
        
        loginAlert.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "eigenes Passwort"
            textField.secureTextEntry = true
        }
        
        
        
        
        let loginAction: UIAlertAction = UIAlertAction(title: "Log-in", style: .Default) { (_) in
            let usernameTextField = loginAlert.textFields![0] as UITextField
            let passwordTextField = loginAlert.textFields![1] as UITextField
            
            
            PFUser.logInWithUsernameInBackground(usernameTextField.text, password: passwordTextField.text){
                (user:PFUser!, error:NSError!)->Void in
                if ((user) != nil){
                    println("Login successfull")
                    //                    var installation:PFInstallation = PFInstallation.currentInstallation()
                    //                    installation.addUniqueObject("Assist", forKey: "Channels")
                    //                    installation["user"] = PFUser.currentUser()
                    //                    installation.saveInBackground()
                    //
                    self.navigationItem.rightBarButtonItem?.enabled = false
                    
                }else{
                    println("Login failed")
                }
                
                
            }
            
        }
        
        loginAlert.addAction(loginAction)
        
        let SignupAction: UIAlertAction = UIAlertAction(title: "Sich registrieren", style: .Default) { (_) in
            let usernameTextField = loginAlert.textFields![0] as UITextField
            let passwordTextField = loginAlert.textFields![1] as UITextField
            
            var user:PFUser = PFUser()
            user.username = usernameTextField.text
            user.password = passwordTextField.text
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    // Hooray! Let them use the app now.
                    println("signing up worked")
                    //                    var installation:PFInstallation = PFInstallation.currentInstallation()
                    //                    installation.addUniqueObject("Assist", forKey: "Channels")
                    //                    installation["user"] = PFUser.currentUser()
                    //                    installation.saveInBackground()
                    
                } else {
                    // Show the errorString somewhere and let the user try again.
                    println("signing up did not worked")
                }
            }
            
        }
        
        loginAlert.addAction(SignupAction)
        
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    
    // Overriding the loadView function to initiate certain parameters for the tableview

    
    override func loadView() {
        let myTableView: UITableView = UITableView.init(frame: UIScreen.mainScreen().bounds, style:UITableViewStyle.Plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.scrollEnabled = true
        myTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view = myTableView;
        
        self.view.autoresizesSubviews = true;
        
        
        var homeButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("viewDidLoad"))
        self.navigationItem.rightBarButtonItem = homeButton
        var logButton : UIBarButtonItem = UIBarButtonItem(image: theMenuIcon, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("bringSideBar"))
        self.navigationItem.leftBarButtonItem = logButton
        
        
        self.getDienstData()
        self.getWeekGrping()
        // construct dienstAA and OA cell
        self.dienstOAundAACell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        self.dienstOAundAACell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        
        
        
        // construct anwesend cell
        
        
        
        // construct abwesend cell
        self.abwesendCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1)
        self.abwesendCell.textLabel?.textColor = UIColor.redColor()
        self.abwesendCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        
        
        
        // construct op cell, section 0, row 1
        self.opCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.opCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        
        // construct aufnahme cell
        self.aufnahmeCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.aufnahmeCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        
        
        // construct visite cell
        self.visiteCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.visiteCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        
        //Construct heute cell
        self.heuteCell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
        self.heuteCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        self.heuteCell.textLabel?.text = "HEUTE " + getCurrentDate()
        
        
        //Construct verteilung cell
        self.verteilungCell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
        self.verteilungCell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15.0)
        self.verteilungCell.textLabel?.text = "AÄ VERTEILUNG"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        switch(section) {
        case 0: return 8    // section 0 has 3 rows
            //        case 1: return 3    // section 1 has 3 row
        default: fatalError("Unknown number of sections")
        }

        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0: return self.heuteCell   // section 0, row 0 is the first name
        case 1: return self.dienstOAundAACell
        case 2: return self.anwesendCell
        case 3: return self.abwesendCell    // section 0, row 1 is the last name
        case 4: return self.verteilungCell
        case 5: return self.opCell       // section 1, row 0 is the share option
        case 6: return self.visiteCell    // section 0, row 1 is the last name
        case 7:return self.aufnahmeCell
        default: fatalError("Unknown row in section 0")
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Implementing the not optional function in SideBar
    
    func sideBarDidSelectButtonAtIndex(index: Int) {
        if index == 0{
            self.performSegueWithIdentifier("gotoNews", sender: self)
            
        } else if index == 1 {
            self.performSegueWithIdentifier("gotoDienstplan", sender: self)
        } else if index == 2 {
            self.performSegueWithIdentifier("gotoFAQs", sender: self)
        } else if index == 3 {
            self.performSegueWithIdentifier("gotoEintritte", sender: self)
        }
        //            else if index == 1{
        //            imageView.backgroundColor = UIColor.clearColor()
        //            imageView.image = UIImage(named: "image2")
        //        }
    }

}
