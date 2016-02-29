//
//  ProfileViewController.swift
//  Tweetster
//
//  Created by William Johnson on 2/27/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileView: ProfileView!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User = User.currentUser!
    var tweets: [Tweet]?
    var screenName: String?
    var id: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let tweet = tweets?[indexPath.row]
        cell.tweet = tweet
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func getUser() {
        if id != User.currentUser!.id! && id != nil  {
            setUp()
        } else {
            id = User.currentUser!.id!
            setUp()
        }
    }
    
    func setUp() {
        let params = ["user_id": id!] as NSDictionary
        TwitterClient.sharedInstance.getUserWithCompletion(params, completion: { (user, error) -> () in
            self.user = user!
            self.setupTable()
            self.getTweets()
            self.setupUserView()
        })
    }
    
    func getTweets(refreshControl: UIRefreshControl? = nil) {
        let params = ["user_id": user.id!] as NSDictionary
        let url = "/1.1/statuses/user_timeline.json"
        TwitterClient.sharedInstance.getTimelineWithParams(params, url: url, completion: { (tweets, error) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailsViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailsViewController") as! DetailsViewController
        
        let tweet = tweets![indexPath.row]
        detailsViewController.tweet = tweet
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func setupUserView() {
        heroImage.setImageWithURL(user.profileBackgroundURL!)
        thumbImage.setImageWithURL(NSURL(string: user.profileImageUrl!)!)
        fullNameLabel.text = user.name
        handleLabel.text = user.screenName
        followersCountLabel.text = String(user.followersCount!)
        followingCountLabel.text = String(user.followingCount!)
        tweetCountLabel.text = String(user.tweetCount!)
    }
    
    func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
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
