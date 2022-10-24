//
//  CGFloatExtensions.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import SwiftUI

extension CGFloat {
    struct Avatar {
        static let medium: CGFloat = 55
        static let small: CGFloat = 37
    }
    
    struct Spacing {
        static let xxs: CGFloat = 4
        static let xs: CGFloat = 8
        static let sm: CGFloat = 16
        static let m: CGFloat = 24
    }
}

extension EdgeInsets {
    static let `default` = EdgeInsets(
        top: .Spacing.sm,
        leading: .Spacing.sm,
        bottom: .Spacing.sm,
        trailing: .Spacing.sm
    )
}
