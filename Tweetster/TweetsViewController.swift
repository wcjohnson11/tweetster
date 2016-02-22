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
        tableView.dataSource = self
        setupRows()
        getTweets()
        addRefreshControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
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
    
    func setupRows() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
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
        if let tweets = tweets {
            let tweet = tweets[indexPath.row]
            cell.fullNameLabel.text = (tweet.user?.name)! as String
            cell.handleLabel.text = (tweet.user?.screenName)! as String
            cell.timestampLabel.text = (tweet.timeAgo)! as String
            cell.tweetTextLabel.text = (tweet.text)! as String
            cell.retweetCount.text = String(tweet.retweetedCount) as String
            cell.heartCount.text = String(tweet.heartedCount) as String
        }
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

}
