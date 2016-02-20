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
    
    class var sharedInstance: TwitterClient {
        struct Static {
             static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    

}
