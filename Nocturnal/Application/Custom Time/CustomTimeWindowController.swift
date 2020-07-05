//
//  CustomTimeWindowController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 9/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class CustomTimeWindowController: NSWindowController {
    override func windowDidLoad() {
        super.windowDidLoad()
        if let window = self.window {
            window.level = .floating
            window.center()
        }
    }
}
