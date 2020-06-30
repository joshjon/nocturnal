//
//  StatusMenu.swift
//  Nocturnal
//
//  Created by Joshua Jon on 25/11/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

class StatusMenu: NSMenu, NSMenuDelegate {
    @IBOutlet var timerMenuItem: NSMenuItem!
    @IBOutlet var nightShiftSliderView: NightShiftSliderView!
    @IBOutlet var dimnessSliderView: DimnessSliderView!
    @IBOutlet var disableMenuItem: NSMenuItem!
    @IBOutlet var disableHourMenuItem: NSMenuItem!
    @IBOutlet var disableCustomMenuItem: NSMenuItem!
    @IBOutlet var hideTouchBarMenuItem: NSMenuItem!
    @IBOutlet var preferencesMenuItem: NSMenuItem!

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    var storyboard = NSStoryboard(name: "Main", bundle: nil)
    var nightShiftSliderMenuItem: NSMenuItem!
    var dimnessSliderMenuItem: NSMenuItem!
    let calendar = NSCalendar(identifier: .gregorian)!

    override func awakeFromNib() {
        delegate = self
        setStatusMenuIcon()
        statusItem.menu = self
        timerMenuItem.isEnabled = false
        timerMenuItem.isHidden = true
        setupNightShiftSliderMenuItem()
        setupDimnessSliderMenuItem()

        // Check if Mac supports TouchBar
        if NSClassFromString("NSTouchBar") == nil {
            hideTouchBarMenuItem.isEnabled = false
            hideTouchBarMenuItem.isHidden = true
        }
    }

    func menuWillOpen(_: NSMenu) {
        updateMenu()
    }

    func updateMenu() {
        // Sliders
        if StateManager.isNocturnalEnabled {
            disableMenuItem.title = "Disable Nocturnal"
            dimnessSliderView.dimnessSlider.isEnabled = true
            nightShiftSliderView.nightShiftSlider.isEnabled = true
            hideTouchBarMenuItem.isEnabled = true
        } else {
            disableMenuItem.title = "Enable Nocturnal"
            dimnessSliderView.dimnessSlider.isEnabled = false
            nightShiftSliderView.nightShiftSlider.isEnabled = false
            hideTouchBarMenuItem.isEnabled = false
        }

        // Timer
        switch StateManager.disableTimer {
        case .off:
            disableHourMenuItem.state = .off
            disableHourMenuItem.isEnabled = true
            disableCustomMenuItem.state = .off
            disableCustomMenuItem.isEnabled = true
        case .hour(timer: _):
            disableHourMenuItem.state = .on
            disableHourMenuItem.isEnabled = true
            disableCustomMenuItem.isEnabled = false
        case .custom(timer: _):
            disableCustomMenuItem.state = .on
            disableCustomMenuItem.isEnabled = true
            disableHourMenuItem.isEnabled = false
        }

        setTimerText(StateManager.isTimerEnabled)

        // TouchBar
        hideTouchBarMenuItem.state = StateManager.isTouchBarHidden ? .on : .off
    }

    func setStatusMenuIcon() {
        if let icon = NSImage(named: NSImage.Name("StatusBarButtonImage")) {
            icon.isTemplate = true
            DispatchQueue.main.async { self.statusItem.button?.image = icon }
        }
    }

    func setupNightShiftSliderMenuItem() {
        nightShiftSliderView.setup()
        nightShiftSliderMenuItem = item(withTitle: "Night Shift Slider")
        nightShiftSliderMenuItem.view = nightShiftSliderView
    }

    func setupDimnessSliderMenuItem() {
        dimnessSliderView.setup()
        dimnessSliderMenuItem = item(withTitle: "Dimness Slider")
        dimnessSliderMenuItem.view = dimnessSliderView
    }

    func setTimerText(_ isTimerEnabled: Bool) {
        if isTimerEnabled {
            var disabledUntilDate: Date

            switch StateManager.disableTimer {
            case .hour(timer: _, endDate: let date), .custom(timer: _, endDate: let date):
                disabledUntilDate = date
            case .off:
                return
            }

            let nowDate = Date()
            let dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter.allowedUnits = [.second]
            let disabledTimeLeftComponents = calendar.components([.second], from: nowDate, to: disabledUntilDate, options: [])
            var disabledHoursLeft = (Double(disabledTimeLeftComponents.second!) / 3600.0).rounded(.down)
            var disabledMinutesLeft = (Double(disabledTimeLeftComponents.second!) / 60.0).truncatingRemainder(dividingBy: 60.0).rounded(.toNearestOrEven)

            if disabledMinutesLeft == 60.0 {
                disabledMinutesLeft = 0.0
                disabledHoursLeft += 1.0
            }

            var hourString = "hrs"
            var minuteString = "mins"
            if disabledHoursLeft == 1 { hourString = "hr" }
            if disabledMinutesLeft == 1 { minuteString = "min" }

            if disabledHoursLeft > 0 {
                timerMenuItem.title = String(format: "Disabled for %01d \(hourString) %01d \(minuteString)", Int(disabledHoursLeft), Int(disabledMinutesLeft))
            } else {
                timerMenuItem.title = String(format: "Disabled for %01d \(minuteString)", Int(disabledMinutesLeft))
            }
            timerMenuItem.isHidden = false
            return
        } else {
            timerMenuItem.isHidden = true
        }
    }

    func localizedPlural(_ key: String, count: Int, comment: String) -> String {
        let format = NSLocalizedString(key, comment: comment)
        return String(format: format, locale: .current, arguments: [count])
    }

    @IBAction func disableClicked(_: NSMenuItem) {
        if StateManager.isNocturnalEnabled {
            StateManager.respond(to: .userDisabledNocturnal)
        } else {
            StateManager.respond(to: .userEnabledNocturnal)
        }
    }

    @IBAction func disableTouchBarClicked(_: NSMenuItem) {
        if StateManager.isTouchBarHidden {
            StateManager.respond(to: .userDisabledTouchBar)
        } else {
            StateManager.respond(to: .userEnabledTouchBar)
        }
    }

    @IBAction func disableHourClicked(_: NSMenuItem) {
        if disableHourMenuItem.state == .off {
            let disableTimer = Timer.scheduledTimer(withTimeInterval: 3600, repeats: false, block: { _ in
                StateManager.disableTimer = .off
                StateManager.respond(to: .disableTimerEnded)
            })

            disableTimer.tolerance = 60
            let currentDate = Date()
            var addComponents = DateComponents()
            addComponents.hour = 1
            let disabledUntilDate = calendar.date(byAdding: addComponents, to: currentDate, options: [])!

            StateManager.disableTimer = .hour(timer: disableTimer, endDate: disabledUntilDate)
            StateManager.respond(to: .disableTimerStarted)
        } else {
            StateManager.disableTimer = .off
            StateManager.respond(to: .disableTimerEnded)
        }
    }

    @IBAction func disableCustomTimeClicked(_: NSMenuItem) {
        let disableCustomTimeWindow = storyboard.instantiateController(withIdentifier: "Custom Time Window Controller") as! CustomTimeWindowController
        if disableCustomMenuItem.state == .off {
            NSApp.activate(ignoringOtherApps: true)
            if !StateManager.isCustomTimeWindowOpen {
                disableCustomTimeWindow.showWindow(nil)
            }
        } else {
            StateManager.disableTimer = .off
            StateManager.respond(to: .disableTimerEnded)
        }
    }

    @IBAction func preferencesClicked(_: NSMenuItem) {
        let preferencesWindow = storyboard.instantiateController(withIdentifier: "Preferences Window Controller") as! PreferencesWindowController
        NSApp.activate(ignoringOtherApps: true)
        if !StateManager.isPreferencesWindowOpen {
            preferencesWindow.showWindow(nil)
        }
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        StateManager.isNocturnalEnabled = false
        // reset so that night shift still works when Nocturnal is closed
        NightShift.blueLightReductionAmount = 1
        NSApplication.shared.terminate(sender)
    }
}
