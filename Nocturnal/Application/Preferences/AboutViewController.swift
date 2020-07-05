//
//  AboutViewController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 4/7/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Cocoa

class AboutViewController: NSViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear() {
        StateManager.isAboutWindowOpen = true
    }

    override func viewWillDisappear() {
        StateManager.isAboutWindowOpen = false
    }
}
