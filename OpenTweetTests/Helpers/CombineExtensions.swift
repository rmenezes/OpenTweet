//
//  CombineExtensions.swift
//  OpenTweetTests
//
//  Created by Raul Menezes on 24/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import Combine

extension AnyPublisher {
    /// Returns a single element (`Just`) erased to an `AnyPublisher`
    static func just<Output, Failure>(
        _ output: Output
    ) -> AnyPublisher<Output, Failure> {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }

    /// Returns a `Failure` erased to an `AnyPublisher`
    static func failure<Output, Failure>(
        _ failure: Failure
    ) -> AnyPublisher<Output, Failure> {
        Fail(error: failure)
            .eraseToAnyPublisher()
    }
}
