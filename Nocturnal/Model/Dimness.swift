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
    
    public static func enable() {
        isDimnessEnabled = true
    }
    
    public static func disable() {
        isDimnessEnabled = false
    }
        
}
