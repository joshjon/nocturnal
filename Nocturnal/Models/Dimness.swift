//
//  Dimness.swift
//  Nocturnal
//
//  Created by Joshua Jon on 5/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

enum Dimness {
    
    private static let dimnessControllers = AppDelegate.sharedDimnessControllers
    private static let fadeDuration = 2.5
    private static var dimnessStrength: CGFloat = 0
    private static var isVisible: Bool = true
    
    static var strength: Float {
        get { return Float(dimnessStrength) }
        set {
            dimnessStrength = CGFloat(newValue)
            for controller in dimnessControllers {
                controller.setAlphaValue(dimnessStrength)
            }
        }
    }
    
    static var isDimnessEnabled: Bool {
        get { return isVisible }
        set {
            isVisible = newValue
            for controller in dimnessControllers {
                controller.setIsVisible(newValue)
            }
        }
    }
    
    static func previewDimnessStrength(_ value: Float) {
        for controller in dimnessControllers {
            controller.setAlphaValue(CGFloat(value))
        }
    }
    
    static func enable() {
        for controller in dimnessControllers {
            controller.fadeIn(fadeDuration)
        }
    }
    
    static func disable() {
        for controller in dimnessControllers {
            controller.fadeOut(fadeDuration)
        }
    }
    
}
