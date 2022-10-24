//
//  TweetContent.swift
//  OpenTweet
//
//  Created by Raul Menezes on 22/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

class TweetContent {
    let value: Tweet
    
    init(value: Tweet) {
        self.value = value
    }
    
    private(set) var children: [TweetContent] = []
    
    func add(child: TweetContent) {
        children.append(child)
    }
    
    var count: Int {
        1 + children.reduce(0) { $0 + $1.count }
    }
}

extension TweetContent: Equatable {
    static func == (
        lhs: TweetContent,
        rhs: TweetContent
    ) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func find(_ value: Tweet) -> TweetContent? {
        if self.value == value {
            return self
        }
        
        for child in children {
            if let match = child.find(value) {
                return match
            }
        }
        
        return nil
    }
}

extension TweetContent: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
    }
}

extension TweetContent {
    func findParentId(_ value: String) -> TweetContent? {
        if self.value.id == value {
            return self
        }
        
        for child in children {
            if let match = child.findParentId(value) {
                return match
            }
        }
        
        return nil
    }
}

extension [TweetContent] {
    func findParentId(_ value: String) -> TweetContent? {
        for item in self {
            if let match = item.findParentId(value) {
                return match
            }
        }
        
        return nil
    }
}
