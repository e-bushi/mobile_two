//
//  Route.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/1/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

enum Resource {
    case posts
    case comments(postId: Int)
    
    func method() ->  String {
        switch self {
        case .posts, .comments:
            return HTTPMethods.get.rawValue
        }
    }
    
    func headerFields(authorization: String) -> [String: String] {
        
        return ["Accept": "application/json",
                "Content-Type": "application/json",
                "Authorization": "Bearer \(authorization)",
            "Host": "api.producthunt.com"
        ]
    }
    
    func urlPath() -> String {
        switch self {
        case .posts:
            return "/v1/posts/all"
            
        case .comments(let postId):
            return "/v1/posts/\(postId)/comments"
        }
    }
    
    func urlParameters() -> [String: String] {
        switch self {
        case .comments(let postId):
            return ["search[post_id]": "\(postId)"]
        
        case .posts:
            return [:]
        }
    }
    
    func HTTPbody() -> Data? {
        switch self {
        case .posts, .comments:
             return nil
        }
    }
}
