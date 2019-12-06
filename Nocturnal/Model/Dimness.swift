//
//  Dimness.swift
//  Nocturnal
//
//  Created by Joshua Jon on 5/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

enum Dimness {
    
    private static let dimnessWindow = NSApplication.shared.windows[1]
    private static let fadeDuration = 3.5
    
    static var dimnessStrength: Float {
        get { return Float(dimnessWindow.alphaValue) }
        set { dimnessWindow.alphaValue = CGFloat(newValue) }
    }
    
    static var isDimnessEnabled: Bool {
        get { return dimnessWindow.isVisible }
        set { dimnessWindow.setIsVisible(newValue)}
    }
    
    static func previewDimnessStrength(_ value: Float) {
        dimnessWindow.alphaValue = CGFloat(value)
    }
    
    static func enable() {
        isDimnessEnabled = true
        dimnessWindow.fadeIn(sender: self, duration: fadeDuration, targetAlpha: CGFloat(dimnessStrength))
    }
    
    static func disable() {
        dimnessWindow.fadeOut(sender: nil, duration: fadeDuration)
        Timer.scheduledTimer(withTimeInterval: fadeDuration, repeats: false, block: { timer in isDimnessEnabled = false })
    }
    
}
