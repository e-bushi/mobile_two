//
//  ProductListingTableViewCell.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/1/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit
import WebKit
class ProductListingTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var productImagery: WKWebView!
    @IBOutlet weak var productName: UILabel!
    
    
    
    var post: Post? {
        didSet{
            let request = URLRequest(url: (post?.thumbNail)!)
            
            productName?.text = post?.name
//            productVoteCount?.text = "\(post!.votesCount)"
            productImagery?.load(request)
        }
    }

}
