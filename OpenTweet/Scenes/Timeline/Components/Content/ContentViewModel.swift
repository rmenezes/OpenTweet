//
//  ContentViewModel.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import Combine

protocol ContentViewModeling {
    var onTap: PassthroughSubject<TweetContentComponent.ContentPart, Never> { get }
    var content: [TweetContentComponent.ContentPart] { get }
    
    func contentTapped(_ content: TweetContentComponent.ContentPart)
}

final class ContentViewModel: ObservableObject {
    @Published var content: [TweetContentComponent.ContentPart] = []
    private let parser = TweetContentComponent()
    
    let onTap = PassthroughSubject<TweetContentComponent.ContentPart, Never>()
    
    init(tweet: Tweet) {
        content = parser.components(for: tweet.content)
    }
}

extension ContentViewModel: ContentViewModeling {
    func contentTapped(
        _ content: TweetContentComponent.ContentPart
    ) {
        onTap.send(content)
    }
}
