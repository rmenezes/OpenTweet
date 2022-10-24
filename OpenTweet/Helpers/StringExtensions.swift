//
//  StringExtensions.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation


extension Optional where Wrapped == String {
    var orEmpty: String {
        self ?? ""
    }
}
