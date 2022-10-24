//
//  ContainerTabBarViewController.swift
//  OpenTweet
//
//  Created by Raul Menezes on 23/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import UIKit

final class ContainerTabBarViewController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [
            makeTabItem(
                TimelineViewController(
                    factory: TimelineComponentFactory()
                ),
                type: .home
            ),
            makeTabItem(UIViewController(), type: .search),
            makeTabItem(UIViewController(), type: .notifications),
            makeTabItem(UIViewController(), type: .messages),
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ContainerTabBarViewController {
    func makeTabItem(
        _ viewController: UIViewController,
        type: TabItemType
    ) -> UIViewController{
        viewController.tabBarItem.title = nil
        viewController.tabBarItem.image = type.image
        return viewController
    }
}
