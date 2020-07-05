//
//  Preferences.swift
//  Nocturnal
//
//  Created by Joshua Jon on 9/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Foundation

enum Shortcuts {
    static let increaseDimness = "increaseDimness"
    static let decreaseDimness = "decreaseDimness"
    static let increaseNightShift = "increaseNightShiftShortcut"
    static let decreaseNightShift = "decreaseNightShiftShortcut"
    static let turnOffTouchBar = "turnOffTouchBar"
    static let disable = "disableNocturnal"
    static let disableHour = "disableHour"
    static let disableCustom = "decreaseNightShiftShortcut"
    static let isInitialized = "isInitialized"
    
    static func setupShortcuts() {
        // Increase Dimness
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Shortcuts.increaseDimness) {
            if StateManager.isNocturnalEnabled {
                Dimness.strength < Dimness.maxStrength ? Dimness.strength += 0.1 : NSSound.beep()
            } else {
                NSSound.beep()
            }
        }
        // Decrease Dimness
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Shortcuts.decreaseDimness) {
            if StateManager.isNocturnalEnabled {
                Dimness.strength > 0 ? Dimness.strength -= 0.1 : NSSound.beep()
            } else {
                NSSound.beep()
            }
        }
        // Increase NightShift
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Shortcuts.increaseNightShift) {
            if StateManager.isNocturnalEnabled {
                NightShift.strength < 1 ? NightShift.strength += 0.1 : NSSound.beep()
            } else {
                NSSound.beep()
            }
        }
        // Decrease NightShift
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Shortcuts.decreaseNightShift) {
            if StateManager.isNocturnalEnabled {
                NightShift.strength > 0 ? NightShift.strength -= 0.1 : NSSound.beep()
            }
        }
        // Turn off TouchBar
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Shortcuts.turnOffTouchBar) {
            // Check if Mac supports TouchBar
            if NSClassFromString("NSTouchBar") != nil {
                if StateManager.isTouchBarOff {
                    StateManager.respond(to: .userDisabledTouchBar)
                } else {
                    StateManager.respond(to: .userEnabledTouchBar)
                }
            }
        }
        // Disable
        MASShortcutBinder.shared().bindShortcut(withDefaultsKey: Shortcuts.disable) {
            if StateManager.isNocturnalEnabled {
                StateManager.respond(to: .userDisabledNocturnal)
            } else {
                StateManager.respond(to: .userEnabledNocturnal)
            }
        }
    }
}

class Preferences {
    private let isAutoLaunchEnabled = "isAutoLaunchEnabled"
    private let userDefaults = UserDefaults.standard

    private init() {
        registerFactoryDefaults()
    }

    private func registerFactoryDefaults() {
        let factoryDefaults = [isAutoLaunchEnabled: NSNumber(value: false)] as [String: Any]

        userDefaults.register(defaults: factoryDefaults)
    }

    func synchronize() {
        userDefaults.synchronize()
    }

    func reset() {
        userDefaults.removeObject(forKey: isAutoLaunchEnabled)
        synchronize()
    }
}
