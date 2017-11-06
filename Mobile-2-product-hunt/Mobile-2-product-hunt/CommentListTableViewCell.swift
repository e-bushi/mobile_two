//
//  CommentListTableViewCell.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/2/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit

class CommentListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userComment: UITextView!
    
    var comments: Comment? {
        didSet {
            userName?.text = comments?.name
            userComment?.text = comments?.body
        }
    }
}
