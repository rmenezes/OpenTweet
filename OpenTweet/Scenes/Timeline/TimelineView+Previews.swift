//
//  TimelineView+Previews.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation

extension TimelineView_Previews {
    final class ViewModel: ObservableObject & TimelineViewModeling {
        var data: [TweetContent] = []
        func onAppear() {}
    }
}
