//
//  TweetCell.swift
//  Tweetster
//
//  Created by William Johnson on 2/21/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var heartCount: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            fullNameLabel.text = (tweet.user?.name)! as String
            handleLabel.text = (tweet.user?.screenName)! as String
            timestampLabel.text = (tweet.timeAgo)! as String
            tweetTextLabel.text = (tweet.text)! as String
            retweetCount.text = String(tweet.retweetedCount!) as String
            heartCount.text = String(tweet.heartedCount!) as String
            thumbImage.setImageWithURL(NSURL(string: (tweet.user?.profileImageUrl)!)!)
            replyImage.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/reply-action_0.png")!)
            retweetImage.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/retweet-action.png")!)
            heartImage.setImageWithURL(NSURL(string: "https://g.twimg.com/dev/documentation/image/like-action.png")!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tweetTextLabel.sizeToFit()
        thumbImage.layer.cornerRadius = 3
        thumbImage.clipsToBounds = true
        
        replyImage.userInteractionEnabled = true
        retweetImage.userInteractionEnabled = true
        heartImage.userInteractionEnabled = true
        
        let replyRecognizer = UITapGestureRecognizer(target: self, action: "replyTapped:")
        let likeRecognizer = UITapGestureRecognizer(target: self, action: "likeTapped:")
        let retweetRecognizer = UITapGestureRecognizer(target: self, action: "retweetTapped:")
        
        replyImage.addGestureRecognizer(replyRecognizer)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
