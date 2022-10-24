//
//  TweetContentBuilderTests.swift
//  OpenTweetTests
//
//  Created by Raul Menezes on 24/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import XCTest
@testable import OpenTweet

final class TweetContentBuilderTests: XCTestCase {
    private var sut: TweetContentBuilder!
    
    override func setUp() {
        super.setUp()
        sut = TweetContentBuilder()
    }
    
    func test_givenAFlatListOfTweets_thenConvertItToATree() {
        // Given
        let tweets = self.tweets
        
        // When
        let tree = sut.build(tweets)
        
        // Then
        XCTAssertEqual(tree.count, 2)
        
        XCTAssertEqual(tree[0].value.id, "00002")
        XCTAssertEqual(tree[1].value.id, "00001")
        
        XCTAssertEqual(tree[1].children.count, 1)
        XCTAssertEqual(tree[1].children[0].value.id, "00003")
        XCTAssertEqual(tree[1].children[0].children.count, 1)
        XCTAssertEqual(tree[1].children[0].children[0].value.id, "00004")
    }
    
    func test_givenAnId_thenReturnNodeRelatedWithReply() throws {
        // Given
        let tweets = self.tweets
        let inReplyTo = "00003"
        
        // When
        let tree = sut.build(tweets)
        
        // Then
        let node = try XCTUnwrap(tree.findParentId(inReplyTo))
        
        XCTAssertEqual(node.children.count, 1)
    }
}

extension TweetContentBuilderTests {
    var tweets: [Tweet] {
        func makeTweet(
            id: String,
            inReplyTo: String? = nil
        ) -> Tweet {
            Tweet(
                id: id,
                author: "@rmenezes89",
                content: "some cool twet",
                avatar: nil,
                date: Date(),
                inReplyTo: inReplyTo,
                images: []
            )
        }
        
        return [
            makeTweet(id: "00001", inReplyTo: nil),
            makeTweet(id: "00002", inReplyTo: nil),
            makeTweet(id: "00003", inReplyTo: "00001"),
            makeTweet(id: "00004", inReplyTo: "00003"),
        ]
    }
}
