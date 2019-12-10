//
//  PreferencesWIndowController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 10/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        guard let window = self.window else { return }
        window.styleMask = [.titled, .closable]
        window.center()
        window.title = "Preferences"
    }
    
}
