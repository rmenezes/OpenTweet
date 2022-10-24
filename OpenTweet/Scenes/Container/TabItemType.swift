//
//  TabItemType.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import UIKit

enum TabItemType {
    case home
    case search
    case notifications
    case messages
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "home")
            
        case .search:
            return UIImage(named: "search")
            
        case .notifications:
            return UIImage(named: "notification")
            
        case .messages:
            return UIImage(named: "messages")
        }
    }
}
