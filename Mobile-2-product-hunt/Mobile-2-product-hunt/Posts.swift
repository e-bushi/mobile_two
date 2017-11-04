//
//  Posts.swift
//  Mobile-2-product-hunt
//
//  Created by Chris Mauldin on 10/30/17.
//  Copyright © 2017 Chris Mauldin. All rights reserved.
//

import Foundation

struct PostsList: Decodable {
    var posts: [Post]
}

struct Post {
    var id: Int
    var name: String
    var tagline: String
    var thumbNail: URL
    var votesCount: Int
}

extension Post: Decodable {
    enum PostKeys: String, CodingKey {
        case id
        case name
        case tagline
        case votesCount = "votes_count"
        case thumbnail
    }
    
    enum ThumbnailKeys: String, CodingKey {
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PostKeys.self)
        
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let tagline = try container.decode(String.self, forKey: .tagline)
        let votesCount = try container.decode(Int.self, forKey: .votesCount)
        
        
        let thumbnailContainer = try container.nestedContainer(keyedBy: ThumbnailKeys.self, forKey: .thumbnail)
        
        let thumbnailImage = try thumbnailContainer.decode(URL.self, forKey: .imageUrl)
        
        
        self.init(id: id, name: name, tagline: tagline, thumbNail: thumbnailImage, votesCount: votesCount)
    }
}









