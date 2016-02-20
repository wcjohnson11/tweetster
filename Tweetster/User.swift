//
//  User.swift
//  Tweetster
//
//  Created by William Johnson on 2/19/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "CurrentUserKey"

class User: NSObject {
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"]  as? String
        screenName = dictionary["screen_name"]  as? String
        profileImageUrl = dictionary["profile_image_url"]  as? String
        tagline = dictionary["description"] as? String
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
            if data != nil {
                do {
                    let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
            _currentUser = User(dictionary: dictionary)
                } catch {
                    print("json read error")
                }
            }
        }
        
            return _currentUser
        }
            
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                do {
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions())
                       NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    print("json write error")
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }


}