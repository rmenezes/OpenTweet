//
//  ThreadViewModelTests.swift
//  OpenTweetTests
//
//  Created by Raul Menezes on 24/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import XCTest
@testable import OpenTweet

final class ThreadViewModelTests: XCTestCase {
    private var sut: ThreadViewModel!
    
    override func setUp() {
        super.setUp()
    }
    
    func test_whenGivenATreeOfTweets_thenFlatResultsForUI() {
        // Given
        let content = tweets
        let sut = makeSUT(content)
        
        // Then
        XCTAssertEqual(content.count, 4)
        XCTAssertEqual(sut.tweets.count, 4)
        
        XCTAssertEqual(sut.tweets.first?.id, "1234")
        XCTAssertEqual(sut.tweets.last?.id, "12346")
    }
}

extension ThreadViewModelTests {
    func makeSUT(_ tweetContent: TweetContent) -> ThreadViewModel {
        return ThreadViewModel(tweetContent)
    }
    
    var tweets: TweetContent {
        func makeTweet(
            id: String,
            inReplyTo: String? = nil
        ) -> TweetContent {
            TweetContent(
                value: Tweet(
                    id: id,
                    author: "@rmenezes89",
                    content: "some cool twet",
                    avatar: nil,
                    date: Date(),
                    inReplyTo: inReplyTo,
                    images: []
                )
            )
        }
        
        let tweetContent = makeTweet(id: "1234")
        let child = makeTweet(id: "12345", inReplyTo: "1234")
        child.add(child: makeTweet(id: "1234567", inReplyTo: "12345"))
        
        tweetContent.add(child: child)
        tweetContent.add(child: makeTweet(id: "12346", inReplyTo: "1234"))
        
        return tweetContent
    }
}
