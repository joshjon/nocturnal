//
//  StateManager.swift
//  Nocturnal
//
//  Created by Joshua Jon on 6/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Foundation

enum NocturnalEvent {
    case disableTimerStarted
    case disableTimerEnded
//    case nightShiftDisableRuleActivated
//    case nightShiftDisableRuleDeactivated
//    case nightShiftEnableRuleActivated
//    case nightShiftEnableRuleDeactivated
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

enum SubdomainRuleType: String, Codable {
    case none
    case disabled
    case enabled
}

enum StateManager {
//    static var userSet: Bool?
    static var userInitiatedShift = false
    static var disabled = false
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
    
    static var disableRuleIsActive: Bool {
        return disabled != false
    }
    
    static var disabledTimer: Bool {
        return disableTimer != .off
    }
    
//    static func removeRulesForCurrentState() {
//        disabled = false
//    }
    
    static func respond(to event: NocturnalEvent) {
        switch event {
//        case .nightShiftDisableRuleActivated:
//            NightShift.isNightShiftEnabled = false
//        case .nightShiftDisableRuleDeactivated:
//            if !disabledTimer && !disableRuleIsActive {
//                    NightShift.isNightShiftEnabled = true
//            }
//        case .nightShiftEnableRuleActivated:
//            NightShift.isNightShiftEnabled = true
//        case .nightShiftEnableRuleDeactivated:
//            if disabledTimer || disableRuleIsActive {
//                NightShift.isNightShiftEnabled = false
//            }
        case .disableTimerStarted:
            disabled = true
            NightShift.disable()
            Dimness.disable()
            
        case .disableTimerEnded:
            disabled = false
            NightShift.enable()
            Dimness.enable()
        }
    }
}
