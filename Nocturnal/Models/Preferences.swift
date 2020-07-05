//
//  Preferences.swift
//  Nocturnal
//
//  Created by Joshua Jon on 9/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Foundation

enum Keys {
    static let isAutoLaunchEnabled = "isAutoLaunchEnabled"
}

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
}

class Preferences {
    static let sharedPrefs = Preferences()

    private var userDefaults: UserDefaults {
        return UserDefaults.standard
    }

    private init() {
        registerFactoryDefaults()
    }

    private func registerFactoryDefaults() {
        let factoryDefaults = [Keys.isAutoLaunchEnabled: NSNumber(value: false)] as [String: Any]

        userDefaults.register(defaults: factoryDefaults)
    }

    func synchronize() {
        userDefaults.synchronize()
    }

    func reset() {
        userDefaults.removeObject(forKey: Keys.isAutoLaunchEnabled)
        synchronize()
    }
}
