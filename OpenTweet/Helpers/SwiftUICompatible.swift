//
//  SwiftUIController.swift
//  OpenTweet
//
//  Created by Raul Menezes on 15/10/2022.
//  Copyright © 2022 OpenTable, Inc. All rights reserved.
//

import Foundation
import SwiftUI

protocol SwiftUICompatible: UIViewController {
    func setupView(_ view: some View)
}

extension SwiftUICompatible {
    func setupView(_ view: some View) {
        let controller = UIHostingController(rootView: view)
        
        addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        self.view.backgroundColor = .white
        
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            controller.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
