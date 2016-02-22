//
//  ComposeTweetViewController.swift
//  Tweetster
//
//  Created by William Johnson on 2/21/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {


    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UITextView!
    
    var tweetReplyId: Int?
    var tweetReplyUsername: String?
    
    @IBAction func backButtonTouched(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func composeTweet(sender: AnyObject) {
        let params: NSMutableDictionary = (dictionary: ["status": tweetTextLabel.text])
        if let tweetReplyId = tweetReplyId {
            params.setValue(tweetReplyId, forKey: "in_reply_to_status_id")
        }
        
        TwitterClient.sharedInstance.createTweetWithCompletion(params) { (tweet, error) -> () in
            self.navigationController?.popViewControllerAnimated(true)
            if error != nil {
                print(error?.description)	
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User.currentUser
        
        thumbImage.setImageWithURL(NSURL(string: (user?.profileImageUrl)!)!)
        fullNameLabel.text = user?.name
        handleLabel.text = user?.screenName
        if let inResponseTo = tweetReplyUsername {
            tweetTextLabel.text = "@\(inResponseTo)"
        }
        self.tweetTextLabel.becomeFirstResponder()
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
