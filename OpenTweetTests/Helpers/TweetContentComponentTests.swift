//
//  TweetContentComponentTests.swift
//  OpenTweetTests
//
//  Created by Raul Menezes on 24/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import XCTest
@testable import OpenTweet

final class TweetContentComponentTests: XCTestCase {
    private var sut: TweetContentComponent!
    
    override func setUp() {
        super.setUp()
        
        sut = TweetContentComponent()
    }
    
    func test_Hashtag() {
        // Given
        let content = "#myhastag"
        
        // When
        let result = sut.components(for: content)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.allSatisfy { $0.type == .hashtag })
    }
    
    func test_Handle() {
        // Given
        let content = "@rmenezes89"
        
        // When
        let result = sut.components(for: content)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.allSatisfy { $0.type == .handle })
    }
    
    func test_link() {
        // Given
        let content = "http://rmenezes.me"
        
        // When
        let result = sut.components(for: content)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.allSatisfy { $0.type == .link })
    }
    
    func test_text() {
        // Given
        let content = "some text"
        
        // When
        let result = sut.components(for: content)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.allSatisfy { $0.type == .text })
    }
    
    func test_complexComposition() {
        // Given
        let content = "some text with #hashtag and @handle. Link as well: http://rmenezes.me"
        
        // When
        let result = sut.components(for: content)
        
        // Then
        XCTAssertEqual(result.count, 10)
        
        let totalHashtag = result.filter { $0.type == .hashtag }
        let totalHandle = result.filter { $0.type == .handle }
        let totalLink = result.filter { $0.type == .link }
        let totalText = result.filter { $0.type == .text }
        
        XCTAssertEqual(totalHashtag.count, 1)
        XCTAssertEqual(totalHandle.count, 1)
        XCTAssertEqual(totalLink.count, 1)
        XCTAssertEqual(totalText.count, 7)
    }
}
