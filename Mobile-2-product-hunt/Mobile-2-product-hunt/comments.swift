//
//  comments.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 11/2/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation

struct CommentsList: Decodable {
    var comments: [Comment]
}

struct Comment {
    var postId: Int
    var body: String
    var name: String
}



extension Comment: Decodable {
    enum CommentKeys: String, CodingKey {
        case postId = "post_id"
        case body
        case user
    }
    
    enum UserKeys: String, CodingKey {
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CommentKeys.self)
        
        let id = try container?.decode(Int.self, forKey: .postId)
        let body = try container?.decode(String.self, forKey: .body)
        let userContainer = try container?.nestedContainer(keyedBy: UserKeys.self, forKey: .user)
        
        let name = try userContainer?.decode(String.self, forKey: .name)
        
        self.init(postId: id!, body: body!, name: name!)
    }
}

