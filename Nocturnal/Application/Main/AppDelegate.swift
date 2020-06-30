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
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initDimnessControllers()
        NightShift.blueLightReductionAmount = 0
        NightShift.enable()
        NotificationCenter.default.addObserver(self, selector: #selector(onNumberOfScreensChanged),
                                               name: NSApplication.didChangeScreenParametersNotification, object: nil)
    }
    
    func initDimnessControllers() {
        for i in 0..<NSScreen.screens.count {
            let dimnessWindow = DimnessWindowController(screen: NSScreen.screens[i])
            AppDelegate.dimnessControllers.append(dimnessWindow)
            dimnessWindow.showWindow(self)
        }
    }
    
    @objc func onNumberOfScreensChanged() {
        AppDelegate.dimnessControllers.removeAll()
        initDimnessControllers()
    }
    
}
