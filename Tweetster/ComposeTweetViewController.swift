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
