//
//  MenuCell.swift
//  Tweetster
//
//  Created by William Johnson on 2/27/16.
//  Copyright © 2016 William Johnson. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var menuLabel: UILabel!
    
    var viewControllers = ["Timeline", "Compose a Tweet"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
