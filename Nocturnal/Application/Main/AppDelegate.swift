//
//  AppDelegate.swift
//  Nocturnal
//
//  Created by Joshua Jon on 16/10/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    static var dimnessControllers = [] as [DimnessWindowController]

    func applicationDidFinishLaunching(_: Notification) {
        verifyMacOsVersion()
        verifySupportsNightShift()
        initDimnessControllers()
        NightShift.strength = 0
        NightShift.enable()
        addNotificationObservers()
        Shortcuts.setupShortcuts()
    }

    func initDimnessControllers() {
        for i in 0 ..< NSScreen.screens.count {
            let dimnessWindow = DimnessWindowController(screen: NSScreen.screens[i])
            AppDelegate.dimnessControllers.append(dimnessWindow)
            dimnessWindow.showWindow(self)
        }
    }

    func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(onNumberOfScreensChanged),
                                               name: NSApplication.didChangeScreenParametersNotification, object: nil)

        DistributedNotificationCenter.default.addObserver(self, selector: #selector(onUnlock),
                                                          name: .init("com.apple.screenIsUnlocked"), object: nil)
    }

    @objc func onNumberOfScreensChanged() {
        AppDelegate.dimnessControllers.removeAll()
        initDimnessControllers()
    }

    @objc func onUnlock() {
        if StateManager.isTouchBarOff {
            do { sleep(1) } // Wait for macOS to init TouchBar
            TouchBar.hideTouchBar()
        }
    }

    func verifyMacOsVersion() {
        if !ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 15, patchVersion: 0)) {
            NSApplication.shared.activate(ignoringOtherApps: true)
            let version = ProcessInfo().operatingSystemVersionString
            let message = "Nocturnal is not supported on this version of macOS"
            let info = "\(version) does not support Nocturnal. Please update macOS to version 10.15 (Catalina) or higher."
            let alert = createAlert(message, info)
            alert.runModal()
            NSApplication.shared.terminate(self)
        }
    }

    func verifySupportsNightShift() {
        if !NightShift.supportsNightShift {
            NSApplication.shared.activate(ignoringOtherApps: true)
            let message = "Your Mac does not support Night Shift"
            let info = "A newer Mac is required to use Nocturnal. To view the list of all compatible Macs click the 'More info...' button."
            let alert = createAlert(message, info)
            alert.addButton(withTitle: "More info...")
            alert.buttons[1].target = self
            alert.buttons[1].action = #selector(moreInfo)
            alert.runModal()
            NSApplication.shared.terminate(self)
        }
    }

    func createAlert(_ message: String, _ info: String) -> NSAlert {
        let alert: NSAlert = NSAlert()
        alert.alertStyle = NSAlert.Style.warning
        alert.messageText = message
        alert.informativeText = info
        alert.addButton(withTitle: "Okay")
        return alert
    }

    @objc func moreInfo() {
        if let url = URL(string: "https://support.apple.com/en-us/HT207513#requirements") {
            NSWorkspace.shared.open(url)
        }
        NSApplication.shared.terminate(self)
    }
}
