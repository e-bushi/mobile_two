//
//  ProductImage.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/3/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import UIKit
import WebKit

class ProductImage: WKWebView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        path.fill()
    }
    
    
    
    

}
