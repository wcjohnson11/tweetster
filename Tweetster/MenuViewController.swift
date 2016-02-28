//
//  MenuViewController.swift
//  Tweetster
//
//  Created by William Johnson on 2/27/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    var hamburgerViewController: HamburgerViewController!
    private var tweetsViewController: UIViewController!
    private var composeTweetViewController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var options = ["Timeline", "Compose a tweet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        self.tableView.reloadData()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        tweetsViewController = storyboard.instantiateViewControllerWithIdentifier("TweetsViewController")
        composeTweetViewController = storyboard.instantiateViewControllerWithIdentifier("ComposeTweetViewController")
        
        viewControllers.append(composeTweetViewController)
        viewControllers.append(tweetsViewController)
        
        hamburgerViewController.contentViewController = tweetsViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell") as! MenuCell
        cell.menuLabel.text = options[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        hamburgerViewController.contentViewController = viewControllers[indexPath.row]
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
