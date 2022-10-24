//
//  TimeLineViewModelTests.swift
//  OpenTweetTests
//
//  Created by Raul Menezes on 24/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import XCTest
import Combine
@testable import OpenTweet

final class TimeLineViewModelTests: XCTestCase {
    private var sut: TimelineViewModel!
    private var service: StubTwitterService!
    
    override func setUp() {
        super.setUp()
        
        service = StubTwitterService()
        sut = TimelineViewModel(service: service)
    }
    
    func test_whenOnAppear_thenFetchData() {
        // Given
        service.fetchAllReturn = [
            Tweet(
                id: "1234",
                author: "@rmenezes89",
                content: "some tweet",
                avatar: nil,
                date: Date(),
                inReplyTo: nil,
                images: []
            )
        ]
        
        // When
        sut.onAppear()
        
        // Then
        XCTAssertEqual(service.fetchAllCount, 1)
    }
}

extension TimeLineViewModelTests {
    final class StubTwitterService: TwitterServicing {
        var fetchAllCount: Int = 0
        var fetchAllReturn: [Tweet] = []
        func fetchAll() -> AnyPublisher<[OpenTweet.Tweet], Error> {
            fetchAllCount += 1
            return .just(fetchAllReturn)
        }
        
        var fetchByUserHandleCount: Int = 0
        var fetchByUserHandleReturn: [Tweet] = []
        func fetchByUserHandle(handle: String) -> AnyPublisher<[OpenTweet.Tweet], Error> {
            fetchByUserHandleCount += 1
            return .just(fetchByUserHandleReturn)
        }
    }
}
