//
//  TwitterService.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import Combine

protocol TwitterServicing {
    func fetchAll() -> AnyPublisher<[Tweet], Error>
    func fetchByUserHandle(handle: String) -> AnyPublisher<[Tweet], Error>
}

struct TwitterService: TwitterServicing {
    let provider: any DataProviding
    func fetchAll() -> AnyPublisher<[Tweet], Error> {
        Future<[Tweet], Error> { promise in
            Task {
                do {
                    guard
                        let response = try await provider.fetch() as? TwitterResponse
                    else {
                        return promise(.success([]))
                    }
                    
                    promise(.success(response.timeline))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchByUserHandle(
        handle: String
    ) -> AnyPublisher<[Tweet], Error> {
        Future<[Tweet], Error> { promise in
            Task {
                do {
                    guard
                        let response = try await provider.fetch() as? TwitterResponse
                    else {
                        return promise(.success([]))
                    }
                    
                    promise(.success(response.timeline.filter { $0.author == handle }))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
