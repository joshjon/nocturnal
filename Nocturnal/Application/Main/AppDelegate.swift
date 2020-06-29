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
    }
    
    func initDimnessControllers() {
        for i in 0..<NSScreen.screens.count {
            let dimnessWindow = DimnessWindowController(NSScreen.screens[i])
            AppDelegate.dimnessControllers.append(dimnessWindow)
            dimnessWindow.showWindow(nil)
        }
    }
    
}
