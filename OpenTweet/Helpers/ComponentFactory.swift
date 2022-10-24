//
//  ComponentFactory.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import SwiftUI

protocol ComponentFactory {  
    func makeView() -> any View
    func makeViewController() -> UIViewController
}

extension ComponentFactory {
    func makeView() -> any View {
        EmptyView()
    }
    
    func makeViewController() -> UIViewController {
        UIViewController()
    }
}
