//
//  TimelineFactory.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import SwiftUI

struct TimelineComponentFactory: ComponentFactory {
    func makeView() -> any View {
        TimelineView(
            viewModel: TimelineViewModel(
                service: TwitterService(
                    provider: LocalDataProvider<TwitterResponse>(fileName: "timeline")
                )
            )
        )
    }
}
