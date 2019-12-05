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
    private static var enabled = false
    private static var strength = Float(0)
    
    static var dimnessStrength: Float {
        get { return strength }
        set { strength = newValue }
    }
    
    static func updateDimnessStrength(_ value: Float) {
        dimnessStrength = value
        dimnessWindow.alphaValue = CGFloat(dimnessStrength)
    }
    
    public static func enable() {
        dimnessWindow.alphaValue = CGFloat(strength)
        enabled = true
    }
    
    public static func disable() {
        dimnessWindow.alphaValue = 0
        enabled = false
    }
    
    static var isDimnessEnabled: Bool {
        get { return enabled }
    }
    
}
