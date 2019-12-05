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
    
    let dimnessWindow = DimnessWindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        dimnessWindow.showWindow(nil)
        NightShift.enable()
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        NightShift.disable()
        NightShift.blueLightReductionAmount = 0
    }
    
}
