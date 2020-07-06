//
//  Utils.swift
//  Nocturnal
//
//  Created by Joshua Jon on 6/7/20.
//  Copyright © 2020 Joshua Jon. All rights reserved.
//

import Foundation

class Utils {
    @objc func openNightShiftInfo() {
        Utils.openUrl(url: "https://support.apple.com/en-us/HT207513#requirements")
        NSApplication.shared.terminate(self)
    }

    static func verifySupportsNightShift() {
        if !NightShift.supportsNightShift {
            NSApplication.shared.activate(ignoringOtherApps: true)
            let message = "Your Mac does not support Night Shift"
            let info = "A newer Mac is required to use Nocturnal. To view the list of all compatible Macs click the 'More info...' button."
            let alert = Utils.createAlert(message, info)
            alert.addButton(withTitle: "More info...")
            alert.buttons[1].target = self
            alert.buttons[1].action = #selector(openNightShiftInfo)
            alert.runModal()
            NSApplication.shared.terminate(self)
        }
    }

    static func verifyMacOsVersion() {
        if !ProcessInfo().isOperatingSystemAtLeast(OperatingSystemVersion(majorVersion: 10, minorVersion: 15, patchVersion: 0)) {
            NSApplication.shared.activate(ignoringOtherApps: true)
            let version = ProcessInfo().operatingSystemVersionString
            let message = "Nocturnal is not supported on this version of macOS"
            let info = "\(version) does not support Nocturnal. Please update macOS to version 10.15 (Catalina) or higher."
            let alert = Utils.createAlert(message, info)
            alert.runModal()
            NSApplication.shared.terminate(self)
        }
    }

    static func openUrl(url: String) {
        if let validUrl = URL(string: url) {
            NSWorkspace.shared.open(validUrl)
        }
    }

    public static func getGrayscaleColorForAppearance() -> NSColor {
        let gray = NSColor.gray
        guard let appearance = UserDefaults.standard.string(forKey: "AppleInterfaceStyle") else { return gray }
        // Custom colors required as default white and black do not take effect in menu
        let white = NSColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let black = NSColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        return appearance == "Dark" ? white : black
    }

    static func createAlert(_ message: String, _ info: String) -> NSAlert {
        let alert: NSAlert = NSAlert()
        alert.alertStyle = NSAlert.Style.warning
        alert.messageText = message
        alert.informativeText = info
        alert.addButton(withTitle: "Okay")
        return alert
    }

    static func getWindowControllerFromStoryboard(identifier: String, floating: Bool = false) -> NSWindowController {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: identifier) as! NSWindowController
        if let window = windowController.window {
            window.center()
            window.styleMask = [.titled, .closable]
            if floating { window.level = .floating }
        }
        return windowController
    }
}
