//
//  ColorExtensions.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import SwiftUI

extension Color {
    struct System {
        private init() {}
        static let placeholder = Color("placeholder")
        static let separator = Color("separator")
    }
    
    struct Brand {
        private init() {}
        static let primary = Color("primary")
        static let primaryText = Color("primaryText")
        static let secondaryText = Color("secondaryText")
    }
}
