//
//  GeneralViewController.swift
//  Nocturnal
//
//  Created by Joshua Jon on 10/12/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa
import LaunchAtLogin

class PreferencesViewController: NSViewController {
    @IBOutlet var increaseDimnessShortcut: MASShortcutView!
    @IBOutlet var decreaseDimnessShortcut: MASShortcutView!
    @IBOutlet var increaseNightShiftShortcut: MASShortcutView!
    @IBOutlet var decreaseNightShiftShortcut: MASShortcutView!
    @IBOutlet var turnOffTouchBarShortcut: MASShortcutView!
    @IBOutlet var disableShortcut: MASShortcutView!
    @IBOutlet var loginAtLaunchButton: NSButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loginAtLaunchButton.state = LaunchAtLogin.isEnabled ? .on : .off
        increaseDimnessShortcut.associatedUserDefaultsKey = Shortcuts.increaseDimness
        decreaseDimnessShortcut.associatedUserDefaultsKey = Shortcuts.decreaseDimness
        increaseNightShiftShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
        decreaseNightShiftShortcut.associatedUserDefaultsKey = Shortcuts.decreaseNightShift
        turnOffTouchBarShortcut.associatedUserDefaultsKey = Shortcuts.turnOffTouchBar
        disableShortcut.associatedUserDefaultsKey = Shortcuts.disable
    }

    override func viewWillAppear() {
        StateManager.isPreferencesWindowOpen = true
    }

    override func viewWillDisappear() {
        StateManager.isPreferencesWindowOpen = false
    }

    @IBAction func loginAtLaunchToggled(_: NSButton) {
        LaunchAtLogin.isEnabled = LaunchAtLogin.isEnabled ? false : true
    }

    @IBAction func clearClicked(_: NSButton) {
        let shortcuts = [Shortcuts.disable, Shortcuts.increaseDimness, Shortcuts.decreaseDimness,
                         Shortcuts.increaseNightShift, Shortcuts.decreaseNightShift, Shortcuts.turnOffTouchBar]
        for shortcut in shortcuts {
            UserDefaults.standard.set(nil, forKey: shortcut)
        }
    }
}
