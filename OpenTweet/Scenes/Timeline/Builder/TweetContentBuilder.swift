//
//  TweetContentBuilder.swift
//  OpenTweet
//
//  Created by Raul Menezes on 22/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

struct TweetContentBuilder {
    func build(
        _ tweets: [Tweet]
    ) -> [TweetContent] {
        var nodes: [TweetContent] = tweets
            .filter { $0.inReplyTo == nil }
            .sorted(by: { $0.id > $1.id })
            .map { TweetContent(value: $0) }
        
        let replies = tweets
            .sorted(by: { $0.id < $1.id })
            .filter { $0.inReplyTo != nil }
        
        return build(replies, nodes: &nodes)
    }
    
    func build(
        _ tweets: [Tweet],
        nodes: inout [TweetContent]
    ) -> [TweetContent] {
        var repliesBuffer: [Tweet] = []
        
        for tweet in tweets {
            if let inReplyTo = tweet.inReplyTo {
                if let reference = nodes.findParentId(inReplyTo) {
                    reference.add(child: TweetContent(value: tweet))
                    continue
                } else {
                    repliesBuffer.append(tweet)
                    continue
                }
            }
        }
        
        if repliesBuffer.count > 0 {
            let buffer = build(repliesBuffer, nodes: &nodes)
            nodes.append(contentsOf: buffer)
        }
        
        return nodes
    }
}
