//
//  Tweet.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

struct TwitterResponse: Decodable {
    let timeline: [Tweet]
}

struct Tweet: Decodable, Equatable {
    let id: String
    let author: String
    let content: String
    let avatar: String?
    let date: Date
    let inReplyTo: String?
    let images: [String]?
    
    init(
        id: String,
        author: String,
        content: String,
        avatar: String?,
        date: Date,
        inReplyTo: String?,
        images: [String]?
    ) {
        self.id = id
        self.author = author
        self.content = content
        self.avatar = avatar
        self.date = date
        self.inReplyTo = inReplyTo
        self.images = images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = ISO8601DateFormatter()
        
        self.id = try container.decode(String.self, forKey: .id)
        self.author = try container.decode(String.self, forKey: .author)
        self.content = try container.decode(String.self, forKey: .content)
        self.avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        self.inReplyTo = try container.decodeIfPresent(String.self, forKey: .inReplyTo)
        self.images = try container.decodeIfPresent([String].self, forKey: .images)
        
        let date = try container.decode(String.self, forKey: .date)
        self.date = dateFormatter.date(from: date) ?? Date()
    }
}

extension Tweet: Hashable {}

extension Tweet {
    enum CodingKeys: CodingKey {
        case id
        case author
        case content
        case avatar
        case date
        case inReplyTo
        case images
    }
}
