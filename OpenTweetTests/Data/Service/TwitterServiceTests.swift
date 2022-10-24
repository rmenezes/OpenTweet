//
//  TwiiterServiceTests.swift
//  OpenTweetTests
//
//  Created by Raul Menezes on 24/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Combine
import XCTest
@testable import OpenTweet

final class TwitterServiceTests: XCTestCase {
    private var sut: TwitterService!
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        cancellables = nil
    }
    
    func test_whenFetchAll_thenShouldReturnTweetFeed() {
        // When
        sut = makeSut()
        let expectation = self.expectation(description: "Request finished")
        var tweets = [Tweet]()
        
        // Then
        
        sut.fetchAll()
            .sink(receiveCompletion: {
                if case .finished = $0 {
                    expectation.fulfill()
                }
            }, receiveValue: {
                tweets = $0
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(tweets.count, 12)
    }
    
    func test_whenByHandle_thenShouldReturnTweetFilteredByHandle() {
        // When
        sut = makeSut()
        let expectation = self.expectation(description: "Request finished")
        var tweets = [Tweet]()
        let userHandle = "@rmenezes89"
        
        // Then
        
        sut.fetchByUserHandle(handle: userHandle)
            .sink(receiveCompletion: {
                if case .finished = $0 {
                    expectation.fulfill()
                }
            }, receiveValue: {
                tweets = $0
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(tweets.count, 5)
    }
    
    func test_whenFetchAllThrowsError_thenShouldThrowError() {
        // When
        sut = makeSut(.error)
        let expectation = self.expectation(description: "Request failed")
        var tweets = [Tweet]()
        
        // Then
        
        sut.fetchAll()
            .sink(receiveCompletion: {
                if case .failure = $0 {
                    expectation.fulfill()
                }
            }, receiveValue: {
                tweets = $0
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertEqual(tweets.count, 0)
    }
}

extension TwitterServiceTests {
    enum TestCase {
        case timeline
        case error
        
        var provider: any DataProviding {
            switch self {
            case .timeline:
                return LocalDataProvider<TwitterResponse>(fileName: "timeline")
            case .error:
                return ErrorDataProvider<TwitterResponse>()
            }
        }
    }
    
    func makeSut(_ testType: TestCase = .timeline) -> TwitterService {
        TwitterService(
            provider: testType.provider
        )
    }
}

extension TwitterServiceTests {
    final class ErrorDataProvider<T: Decodable>: DataProviding {
        func fetch() async throws -> T {
            throw DataError.invalidPath
        }
    }
}
