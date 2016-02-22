//
//  DetailsViewController.swift
//  Tweetster
//
//  Created by William Johnson on 2/21/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var tweetTimestampLabel: UILabel!
    var tweet: Tweet?
    

    @IBAction func backButtonTouched(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func composeReply(sender: AnyObject) {
        print("\(tweet)")
        if let tweet = tweet {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("ComposeTweetViewController") as! ComposeTweetViewController!
            navigationController?.pushViewController(vc, animated: true)
            vc.tweetReplyId = tweet.id
            vc.tweetReplyUsername = tweet.user?.screenName
        }
    }
 
    
    @IBAction func retweetTouched(sender: AnyObject) {
        tweet!.retweetedCount = tweet!.retweetedCount! + 1
        TwitterClient.sharedInstance.retweetWithCompletion(tweet!.id!) { (retweet, error) -> () in
            if let _ = retweet {
                print("retweeted")
            } else {
                print(error)
            }
        }
    }
    

    @IBAction func heartTouched(sender: AnyObject) {
        tweet!.heartedCount = tweet!.heartedCount! + 1
        TwitterClient.sharedInstance.favoriteWithCompletion(tweet!.id!) { (heartTweet, error) -> () in
            if let _ = heartTweet {
                print("hearted")
            } else {
                print(error)
            }

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        thumbImage.setImageWithURL(NSURL(string: (tweet?.user?.profileImageUrl)!)!)
        fullNameLabel.text = tweet?.user?.name
        handleLabel.text = tweet?.user?.screenName
        tweetTextLabel.text = tweet?.text
        tweetTimestampLabel.text = tweet?.createdAtString
        retweetCountLabel.text = String(tweet?.retweetedCount!)
        heartLabel.text = String(tweet?.heartedCount!)

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
