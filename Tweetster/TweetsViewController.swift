//
//  TweetsViewController.swift
//  Tweetster
//
//  Created by William Johnson on 2/19/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]?
    var refreshControl: UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupRows()
        getTweets()
        addRefreshControl()
    }
    
    func replyTapped(gestureRecognizer: UITapGestureRecognizer) {

    }
    
    func likeTapped(gestureRecognizer: UITapGestureRecognizer) {
        
    }
    
    func retweetTapped(gestureRecognizer: UITapGestureRecognizer) {
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func setupRows() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func getTweets(refreshControl: UIRefreshControl? = nil) {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            if let refreshControl = refreshControl {
                refreshControl.endRefreshing()
            }
        }
    }
    
    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: "refreshCallback:", forControlEvents: .ValueChanged)
        tableView.insertSubview(refreshControl!, atIndex: 0)
    }
    
    func refreshCallback(refreshControl: UIRefreshControl) {
        getTweets(refreshControl)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
        cell.tweet = tweets![indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        var indexPath: NSIndexPath? = nil
        if let cell = sender as? TweetCell {
           indexPath = tableView.indexPathForCell(cell)
            let tweet = tweets![indexPath!.row]
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            self.tableView.deselectRowAtIndexPath(indexPath!, animated: true)
            detailsViewController.tweet = tweet

        }
    }

}
