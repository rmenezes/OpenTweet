//
//  ThreadViewModel.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

protocol ThreadViewModeling {
    var tweets: [Tweet] { get }
}

final class ThreadViewModel: ObservableObject {
    @Published var tweets: [Tweet] = []
    
    init(_ content: TweetContent) {
        self.tweets = flattenTweetTree(content)
    }
    
    func flattenTweetTree(
        _ content: TweetContent
    ) -> [Tweet] {
        var nodes: [Tweet] = []
        
        nodes.append(content.value)
        
        for item in content.children.sorted(by: { $0.value.id < $1.value.id }) {
            let contents = flattenTweetTree(item)
            nodes.append(contentsOf: contents)
        }
        
        return nodes
    }
}

extension ThreadViewModel: ThreadViewModeling {}
