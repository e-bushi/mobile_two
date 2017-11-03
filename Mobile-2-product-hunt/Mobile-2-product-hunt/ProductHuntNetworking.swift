//
//  ProductHuntNetworking.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 10/30/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation


class ProductHuntNetwork {
    let session = URLSession.shared
    let baseUrl = URL(string: "https://api.producthunt.com/")
    
    func fetch(resource: Resource, completion: @escaping ([Any]) -> ()) {
        
        let fullUrl = baseUrl?.appendingPathComponent(resource.urlPath())
        var request = URLRequest(url: fullUrl!)
        request.httpMethod = resource.method()
        request.allHTTPHeaderFields = resource.headerFields(authorization: "f5e73a2e944f5ebc819671ed28d7866f93221038be16b623a413a14e482cb226")
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                
                let postList = try? JSONDecoder().decode(PostsList.self, from: data)
                guard let posts = postList?.posts else {return}
                completion(posts)
            }
        }.resume()
        
        
    }
    
    
   
}
