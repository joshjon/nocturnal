//
//  AppDelegate.swift
//  Nocturnal
//
//  Created by Joshua Jon on 16/10/19.
//  Copyright © 2019 Joshua Jon. All rights reserved.
//

import Cocoa
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    static var dimnessControllers = [] as [DimnessWindowController]
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        initDimnessControllers()
        NightShift.blueLightReductionAmount = 0
        NightShift.enable()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidConnectScreen(_:)), name: NSApplication.didChangeScreenParametersNotification, object: nil)
    }
    
    func initDimnessControllers() {
        for i in 0..<NSScreen.screens.count {
            let dimnessWindow = DimnessWindowController(NSScreen.screens[i])
            AppDelegate.dimnessControllers.append(dimnessWindow)
            dimnessWindow.showWindow(self)
        }
    }
    
    @objc func onDidConnectScreen(_ notification:Notification) {
        print("====== Notification received ======")
        for controller in AppDelegate.dimnessControllers {
            controller = nil
        }
        AppDelegate.dimnessControllers.removeAll()
        initDimnessControllers()
        print("Controller count: \(AppDelegate.dimnessControllers.count)")
        print("Strength: \(Dimness.strength)")
    }
    
}
