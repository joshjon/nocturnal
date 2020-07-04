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
    @IBOutlet var sourceCodeLabel: NSTextField!
    @IBOutlet var loginAtLaunchButton: NSButton!
    @IBOutlet var increaseDimnessShortcut: MASShortcutView!
    @IBOutlet var decreaseDimnessShortcut: MASShortcutView!
    @IBOutlet var increaseNightShiftShortcut: MASShortcutView!
    @IBOutlet var decreaseNightShiftShortcut: MASShortcutView!
    @IBOutlet var turnOffTouchBarShortcut: MASShortcutView!
    @IBOutlet var disableShortcut: MASShortcutView!

     let statusMenuController = (NSApplication.shared.delegate as? AppDelegate)?.menu.delegate as? MenuController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAtLaunchButton.state = LaunchAtLogin.isEnabled ? .on : .off
        increaseDimnessShortcut.associatedUserDefaultsKey = Shortcuts.increaseDimness
        decreaseDimnessShortcut.associatedUserDefaultsKey = Shortcuts.decreaseDimness
        increaseNightShiftShortcut.associatedUserDefaultsKey = Shortcuts.increaseDimness
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
}
