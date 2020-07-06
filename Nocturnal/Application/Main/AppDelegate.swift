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
        Utils.verifyMacOsVersion()
        Utils.verifySupportsNightShift()
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
}
