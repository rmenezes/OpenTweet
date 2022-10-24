//
//  ViewController.swift
//  OpenTweet
//
//  Created by Olivier Larivain on 9/30/16.
//  Copyright © 2016 OpenTable, Inc. All rights reserved.
//

import UIKit

final class TimelineViewController: UIViewController {
    private let factory: ComponentFactory
    
    init(factory: ComponentFactory) {
        self.factory = factory
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        
        setupView(factory.makeView())
	}
}

extension TimelineViewController: SwiftUICompatible {}
