//
//  Dimness.swift
//  Nocturnal
//
//  Created by Joshua Jon on 5/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Foundation

enum Dimness {
    public static let maxStrength: Float = 0.9
    private static let fadeDuration = 2.5
    private static var dimnessStrength: CGFloat = CGFloat(Settings.dimnessStrength)
    private static var isVisible: Bool = true

    static var strength: Float {
        get { return Float(dimnessStrength) }
        set {
            dimnessStrength = CGFloat(newValue)
            for controller in AppDelegate.dimnessControllers {
                controller.setAlphaValue(dimnessStrength)
            }
            Settings.dimnessStrength = newValue
        }
    }

    static var isDimnessEnabled: Bool {
        get { return isVisible }
        set {
            isVisible = newValue
            for controller in AppDelegate.dimnessControllers {
                controller.setIsVisible(newValue)
            }
        }
    }

    static func enable() {
        for controller in AppDelegate.dimnessControllers {
            controller.fadeIn(fadeDuration)
        }
    }

    static func disable() {
        for controller in AppDelegate.dimnessControllers {
            controller.fadeOut(fadeDuration)
        }
    }
}
