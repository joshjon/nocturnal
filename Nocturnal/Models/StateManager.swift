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
    case userEnabledTouchBar
    case userDisabledTouchBar
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
    private static var enabled = true
    private static var touchBarHidden = false
    private static var userInitiatedShift = false
    private static var fadeInAnimationActive = false
    private static var customTimeWindowOpen = false
    private static var preferencesWindowOpen = false

    static var disableTimer = DisableTimer.off {
        willSet {
            switch disableTimer {
            case let .hour(timer, _), let .custom(timer, _):
                timer.invalidate()
            default:
                break
            }
        }
    }

    static var isFadeInAnimationActive: Bool {
        get { return fadeInAnimationActive }
        set { fadeInAnimationActive = newValue }
    }

    static var isCustomTimeWindowOpen: Bool {
        get { return customTimeWindowOpen }
        set { customTimeWindowOpen = newValue }
    }

    static var isPreferencesWindowOpen: Bool {
        get { return preferencesWindowOpen }
        set { preferencesWindowOpen = newValue }
    }

    static var isTimerEnabled: Bool {
        return disableTimer != .off
    }

    static var isNocturnalEnabled: Bool {
        get { return enabled }
        set {
            enabled = newValue
            if newValue {
                NightShift.enable()
                Dimness.enable()
                if isTouchBarOff {
                    TouchBar.hideTouchBar()
                }
            } else {
                NightShift.disable()
                Dimness.disable()
                TouchBar.showTouchbar()
            }
        }
    }

    static var isTouchBarOff: Bool {
        get { return touchBarHidden }
        set {
            touchBarHidden = newValue
            if newValue {
                TouchBar.hideTouchBar()
            } else {
                TouchBar.showTouchbar()
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
        case .userEnabledTouchBar:
            isTouchBarOff = true
        case .userDisabledTouchBar:
            isTouchBarOff = false
        case .disableTimerStarted:
                isNocturnalEnabled = false
        case .disableTimerEnded:
            isNocturnalEnabled = true
        }
    }
}
