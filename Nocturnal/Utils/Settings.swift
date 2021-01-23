//
//  Settings.swift
//  Nocturnal
//
//  Created by Karanvir Panesar on 1/22/21.
//  Copyright © 2021 Joshua Jon. All rights reserved.
//

import Foundation

enum Settings {
    private static let defaults = UserDefaults.standard
    private static let dimnessStrengthKey = "DimnessStrength"
    private static let nightShiftStrengthKey = "NighShiftStrength"
    private static let initializedKey = "Initialized"
    
    static func initialize() {
        if(!defaults.bool(forKey: initializedKey)) {
            defaults.set(0.2, forKey: nightShiftStrengthKey)
            defaults.set(0.2, forKey: dimnessStrengthKey)
            defaults.set(true, forKey: initializedKey)
        }
    }
    
    static var dimnessStrength: Float {
        get { return defaults.float(forKey: dimnessStrengthKey) }
        set { defaults.set(newValue, forKey: dimnessStrengthKey) }
    }
    static var nightShiftStrength: Float {
        get { return defaults.float(forKey: nightShiftStrengthKey) }
        set { defaults.set(newValue, forKey: nightShiftStrengthKey) }
    }
}
