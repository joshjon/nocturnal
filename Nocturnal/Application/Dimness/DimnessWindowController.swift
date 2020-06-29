//
//  DimnessWindowController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 25/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class DimnessWindowController: NSWindowController {
    
    var screen: NSScreen
    
    init(_ screen: NSScreen){
        self.screen = screen
        let window = NSWindow()
        window.setFrame(self.screen.frame, display: true)
        window.alphaValue = 0
        window.ignoresMouseEvents = true
        window.backgroundColor = .black
        window.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(.overlayWindow)))
        window.styleMask = [.fullScreen]
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        super.init(window: window)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(NSScreen.main!)
    }
    
    func setAlphaValue(_ value: CGFloat) {
        if let window = self.window {
            window.alphaValue = value
        }
    }
    
    func setIsVisible(_ bool: Bool) {
        if let window = self.window {
            window.setIsVisible(bool)
        }
    }
    
    func fadeIn(_ duration: Double) {
        if let window = self.window {
            window.fadeInNew(duration: duration)
        }
    }
    
    func fadeOut(_ duration: Double) {
        if let window = self.window {
            window.fadeOutNew(duration: duration)
        }
    }
    
}
