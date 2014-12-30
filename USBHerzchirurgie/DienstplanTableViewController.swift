//
//  DienstplanTableViewController.swift
//  USBHerzchirurgie
//
//  Created by Felix on 30/12/14.
//  Copyright (c) 2014 Felix. All rights reserved.
//

import UIKit

class DienstplanTableViewController: UITableViewController , UITableViewDataSource, UITableViewDelegate {
    
    //    override func loadView() {
    //        let planTableView: UITableView = UITableView.init(frame: UIScreen.mainScreen().bounds,style:UITableViewStyle.Grouped )
    //        planTableView.delegate = self
    //        planTableView.dataSource = self
    //        planTableView.scrollEnabled = true
    //        self.view = planTableView;
    //
    //        self.view.autoresizesSubviews = true;
    //
    //    }
    
    //var sideBar:SideBar = SideBar()
    
    func getCurrentDate() -> String {
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        var stringDate = formatter.stringFromDate(date)
        return stringDate
        
    }
    
    func getMonthWithDots() -> String {
        
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = ".MM."
        var stringDate = formatter.stringFromDate(date)
        return stringDate
        
    }
    
    
    var Dienste:NSMutableArray! = NSMutableArray()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        sideBar = SideBar(sourceView: self.view, menuItems: ["first item", "second item", "funny item", "another item", "second item", "second item", "second item", "second item"])
        //        sideBar.delegate = self
        
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 44
        
        var monthsWithDots = self.getMonthWithDots()
        var findDienste = PFQuery(className: "Dienste")
        findDienste.whereKey("date", containsString: monthsWithDots)
        findDienste.orderByDescending("date")
        findDienste.cachePolicy = kPFCachePolicyCacheElseNetwork
        
        findDienste.findObjectsInBackgroundWithBlock {
            (objects:[AnyObject]!, error:NSError!)->Void in
            
            if error == nil{
                for object in objects {
                    let dailyplan:PFObject = object as PFObject
                    self.Dienste.addObject(dailyplan)
                    //tableView.reloadData()
                }
                let array:NSArray = self.Dienste.reverseObjectEnumerator().allObjects
                self.Dienste = NSMutableArray(array: array)
                self.tableView.reloadData()
                
            }
        }
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dienste.count
    }
    
    //    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell { {
    //        let cell = tableView.dequeueReusableCellWithIdentifier("dienstCell", forIndexPath: indexPath) as CustomCellTableViewCell
    //
    ////        cell.labUerName.text = "Name"
    ////        cell.labMessage.text = "Message \(indexPath.row)"
    ////        cell.labTime.text = NSDateFormatter.localizedStringFromDate(NSDate.date(), dateStyle: .ShortStyle, timeStyle: .ShortStyle)
    //
    //        return cell
    //    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dienstCell", forIndexPath: indexPath) as DienstplanTableViewCell
        
        // Configure the cell...
        
        let dienst:PFObject = self.Dienste.objectAtIndex(indexPath.row) as PFObject
        var date = dienst.objectForKey("date") as? String
        var aa = dienst.objectForKey("AA") as? String
        var oa = dienst.objectForKey("OA") as? String
        var todaysdate = getCurrentDate()
        if (todaysdate == date!) {
            cell.backgroundColor = UIColor(red: 226/255.0, green: 226.0/255.0, blue: 226.0/255.0, alpha: 1)
        }
        cell.dateLabel.text = date!
        cell.dienstAAundOA.text = aa! + ", " + oa!
        var ab = "Abwesend: "
        var away = ""
        cell.abwesend.text = dienst.objectForKey("abwesend") as? String
        
        //        if indexPath.row % 2 == 0 {
        //            cell.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
        //        }
        
        
        
        return cell
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
    
    
    //    func sideBarDidSelectButtonAtIndex(index: Int) {
    //        //        if index == 0{
    //        //            imageView.backgroundColor = UIColor.redColor()
    //        //            imageView.image = nil
    //        //        } else if index == 1{
    //        //            imageView.backgroundColor = UIColor.clearColor()
    //        //            imageView.image = UIImage(named: "image2")
    //        //        }
    //    }
    
    
}
