//
//  User.swift
//  Tweetster
//
//  Created by William Johnson on 2/19/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

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
    
    


}
