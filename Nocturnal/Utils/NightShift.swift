//
//  NightShift.swift
//  Nocturnal
//
//  Created by Joshua Jon on 19/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Foundation

enum NightShift {
    
    private static let client = CBBlueLightClient()
    
    private static var blueLightStatus: Status {
        var status: Status = Status()
        client.getBlueLightStatus(&status)
        return status
    }
    
    static func setBlueLightReductionAmount(_ value: Float) {
        client.setStrength(value, commit: false)
    }
    
    static var isNightShiftEnabled: Bool {
        get { return blueLightStatus.enabled.boolValue }
        set { client.setEnabled(newValue) }
    }
    
    public static func enable() {
        isNightShiftEnabled = true
    }
    
    public static func disable() {
        setBlueLightReductionAmount(0)
        isNightShiftEnabled = false
    }
    
}


