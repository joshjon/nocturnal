//
//  StateManager.swift
//  Nocturnal
//
//  Created by Joshua Jon on 6/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Foundation

enum NocturnalEvent {
    case userDisabledNocturnal
    case userEnabledNocturnal
    case disableTimerStarted
    case disableTimerEnded
}

enum DisableTimer: Equatable {
    case off
    case hour(timer: Timer, endDate: Date)
    case custom(timer: Timer, endDate: Date)
    
    static func == (lhs: DisableTimer, rhs: DisableTimer) -> Bool {
        switch (lhs, rhs) {
        case (.off, .off):
            return true
        case (let .hour(leftTimer, leftDate), let .hour(rightTimer, rightDate)),
             (let .custom(leftTimer, leftDate), let .custom(rightTimer, rightDate)):
            return leftTimer == rightTimer && leftDate == rightDate
        default:
            return false
        }
    }
}

enum StateManager {
    static var userInitiatedShift = false
    static var enabled = true
    static var fadeInAnimationActive = false
    
    static var disableTimer = DisableTimer.off {
        willSet {
            switch disableTimer {
            case .hour(let timer, _), .custom(let timer, _):
                timer.invalidate()
            default: break
            }
        }
    }
    
    static var isFadeInAnimationActive: Bool {
        get { return fadeInAnimationActive }
        set { fadeInAnimationActive = newValue}
    }
    
    static var disabledTimer: Bool {
        return disableTimer != .off
    }
    
    static var isNocturnalEnabled: Bool {
        get { return enabled }
        set {
            enabled = newValue
            if newValue {
                NightShift.enable()
                Dimness.enable()
            } else {
                NightShift.disable()
                Dimness.disable()
            }
        }
    }
    
    static func respond(to event: NocturnalEvent) {
        switch event {
        case .userEnabledNocturnal:
            disableTimer = .off
            isNocturnalEnabled = true
        case .userDisabledNocturnal:
            isNocturnalEnabled = false
        case .disableTimerStarted:
            // check is required as Nocturnal can already be disabled when a timer starts
            if isNocturnalEnabled {
                isNocturnalEnabled = false
            }
        case .disableTimerEnded:
            isNocturnalEnabled = true
        }
    }
}
