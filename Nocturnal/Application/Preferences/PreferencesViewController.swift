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
    @IBOutlet var dimnessToggleShortcut: MASShortcutView!
    
     let statusMenuController = (NSApplication.shared.delegate as? AppDelegate)?.menu.delegate as? MenuController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginAtLaunchButton.state = LaunchAtLogin.isEnabled ? .on : .off
        dimnessToggleShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
        dimnessToggleShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
        dimnessToggleShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
        dimnessToggleShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
        dimnessToggleShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
        dimnessToggleShortcut.associatedUserDefaultsKey = Shortcuts.increaseNightShift
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
