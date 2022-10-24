//
//  TweetContentComponent.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

struct TweetContentComponent {
    private static let hashtagIdentifier = #"(#)\w+"#
    private static let handleIdentifier = #"(@)\w+"#
    private static let linkIdentifier = #"(https?:\/\/)?[\w\-~]+(\.[\w\-~]+)+(\/[\w\-~@:%]*)*(#[\w\-]*)?(\?[^\s]*)?"#
    private static let imageIdentifier = #"\.(jpg|jpeg|png|webp|avif|gif|svg)"#
    
    /// Very very very dummy parser. Not ment to be used in production code.
    func components(
        for content: String
    ) -> [ContentPart] {
        content
            .replacingOccurrences(of: "\r", with: " ")
            .replacingOccurrences(of: "\n", with: " ")
            .split(separator: " ")
            .map(String.init)
            .map { component in
                if component.range(of: Self.hashtagIdentifier, options: .regularExpression) != nil {
                    return ContentPart(text: component, type: .hashtag)
                } else if component.range(of: Self.handleIdentifier, options: .regularExpression) != nil {
                    return ContentPart(text: component, type: .handle)
                } else if component.range(of: Self.linkIdentifier, options: .regularExpression) != nil {
                    return ContentPart(text: component, type: .link)
                }
                
                return ContentPart(text: component, type: .text)
            }
    }
}

// MARK: - ContentPart

extension TweetContentComponent {
    struct ContentPart: Hashable, Identifiable {
        let id = UUID().uuidString
        let text: String
        let type: ContentType
    }
}
