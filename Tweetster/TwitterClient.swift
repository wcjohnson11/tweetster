//
//  TwitterClient.swift
//  Tweetster
//
//  Created by William Johnson on 2/19/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "0LGTKa7iIRCNdASYhI4rr4ORQ"
let twitterConsumerSecret = "Fcntjwj5fVYXEqscXbdacsXQ3xDgFe0ZrcG48PPkTJ6jGZcwlz"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json",
            parameters: nil,
            progress: { (progress: NSProgress) -> Void in },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweets = Tweet.tweetsWithArray((response as! [NSDictionary]))
                completion(tweets: tweets, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil,
            success: { (requestToken: BDBOAuth1Credential!) -> Void
                in print("we got creds")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            },
            failure: { (error: NSError!) -> Void in
                print("failed to get creds")
        })
    }
    
    func openURL(url: NSURL) {
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (requestToken: BDBOAuth1Credential!) -> Void in
                print("we got access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(requestToken)
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                    progress: { (progress: NSProgress) -> Void in },
                    success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                        let user = User(dictionary: response as! NSDictionary)
                        User.currentUser = user
                        self.loginCompletion?(user: user, error: nil)
                    },
                    failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                        print("error getting current user")
                        self.loginCompletion?(user: nil, error: error)
                })
            },
            failure: { (error: NSError!) -> Void in
                print("failed to get access token")
            }
        )
    }
    
    func createTweetWithCompletion(params: NSDictionary, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json",
            parameters: params,
            progress: { (progress: NSProgress) -> Void in },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error creating tweet")
                completion(tweet: nil, error: error)
        })
    }
    
    func retweetWithCompletion(id: Int, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id).json",
            parameters: nil,
            progress: { (progress: NSProgress) -> Void in },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error retweeting")
                completion(tweet: nil, error: error)
        })
    }
    
    func unretweetWithCompletion(id: Int, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/unretweet/\(id).json",
            parameters: nil,
            progress: { (progress: NSProgress) -> Void in },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error un-retweeting")
                completion(tweet: nil, error: error)
        })
    }
    
    func favoriteWithCompletion(id: Int?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json",
            parameters: NSDictionary(dictionary: ["id": id!]),
            progress: { (progress: NSProgress) -> Void in },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error favoriting")
                completion(tweet: nil, error: error)
        })
    }
    
    func unfavoriteWithCompletion(id: Int?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/favorites/destroy.json",
            parameters: NSDictionary(dictionary: ["id": id!]),
            progress: { (progress: NSProgress) -> Void in },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let tweet = Tweet(dictionary: response as! NSDictionary)
                completion(tweet: tweet, error: nil)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error unfavoriting")
                completion(tweet: nil, error: error)
        })
    }
}
