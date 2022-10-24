//
//  TweetView+Preview.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

extension TweetView_Previews {
    static var mock: Tweet {
        Tweet(
            id: "1234",
            author: "@rmenezes89",
            content: "Long day at opentable!\nShipped a great update, should be on the store next week.\nhttps://itunes.apple.com/us/app/opentable/id296581815?mt=8",
            avatar: "https://avatars.githubusercontent.com/u/1154679?v=4",
            date: Date(),
            inReplyTo: "123",
                images: []
        )
    }
}
