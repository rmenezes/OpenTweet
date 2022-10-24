//
//  DataProvider.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

enum DataError: Error {
    case invalidPath
    case generic(Error)
}

/// This could be implemented on top of `URLSession`
protocol DataProviding {
    associatedtype T: Decodable
    func fetch() async throws -> T
}

struct LocalDataProvider<T: Decodable>: DataProviding {
    let fileName: String
    
    func fetch() async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            do {
                let bundle = Bundle.main
                guard
                    let path = bundle.path(forResource: fileName, ofType: "json")
                else {
                    return continuation.resume(throwing: DataError.invalidPath)
                }
                
                let data = try Data(
                    contentsOf: URL(fileURLWithPath: path),
                    options: .mappedIfSafe
                )
                
                let result = try JSONDecoder().decode(T.self, from: data)
                
                continuation.resume(returning: result)
            } catch {
                continuation.resume(throwing: DataError.generic(error))
            }
        }
    }
}
