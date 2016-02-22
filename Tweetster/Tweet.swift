//
//  Tweet.swift
//  Tweetster
//
//  Created by William Johnson on 2/19/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var id: Int?
    var inReplyToScreenName: String?
    var retweeted: Bool?
    var retweetedCount: Int?
    var hearted: Bool?
    var heartedCount: Int?
    var timeAgo: Int?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        id = dictionary["id"] as? Int
        inReplyToScreenName = dictionary["in_reply_to_screen_name"] as? String
        retweeted = dictionary["retweeted"] as? Bool ?? false
        retweetedCount = dictionary["retweet_count"] as? Int ?? 0
        hearted = dictionary["favorited"] as? Bool ?? false
        heartedCount = dictionary["favorites_count"] as? Int ?? 0
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
}
