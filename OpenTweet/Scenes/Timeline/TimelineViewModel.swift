//
//  TimelineViewModel.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Combine
import Foundation

protocol TimelineViewModeling: ObservableObject {
    var data: [TweetContent] { get }
    func onAppear()
}

final class TimelineViewModel: ObservableObject {
    private let service: TwitterServicing
    private let builder: TweetContentBuilder
    private var cancellables = Set<AnyCancellable>()
    
    @Published private (set) var data: [TweetContent] = []
    
    init(
        service: TwitterServicing
    ) {
        self.service = service
        self.builder = TweetContentBuilder()
    }
}

// MARK: - TimelineViewModeling

extension TimelineViewModel: TimelineViewModeling {
    func onAppear() {
        service
            .fetchAll()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] in
                    guard let self else { return }
                    // Build a Tree with the elements
                    let data = self.builder.build($0)
                    self.data = data
                }
            )
            .store(in: &cancellables)
    }
}
