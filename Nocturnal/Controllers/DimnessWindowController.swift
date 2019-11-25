//
//  DimnessWindowController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 25/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class DimnessWindowController: NSWindowController {
    
    override func windowDidLoad() {
        super.windowDidLoad()
        guard let screen = NSScreen.main else { return }
        guard let window = self.window else { return }
        setup(window: window, frame: screen.frame)
    }
    
    func setup(window: NSWindow, frame: NSRect) {
        window.setFrame(frame, display: true)
        window.center()
        window.alphaValue = 0
        window.ignoresMouseEvents = true
        window.backgroundColor = .black
        window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.overlayWindow)))
        window.styleMask = [.fullScreen]
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    }
    
}
